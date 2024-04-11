resource "azurerm_virtual_network" "core" {
  name                = "vnet-${var.tre_id}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.core_address_space]
  tags                = local.tre_core_tags

  ddos_protection_plan {
    enable = true
    id     = var.ddos_plan_id
  }

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_subnet" "bastion" {
  count                = var.deploy_bastion ? 1 : 0
  name                 = "AzureBastionSubnet"
  virtual_network_name = azurerm_virtual_network.core.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [local.bastion_subnet_address_prefix]

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_subnet" "azure_firewall" {
  count                = var.deploy_firewall ? 1 : 0
  name                 = "AzureFirewallSubnet"
  virtual_network_name = azurerm_virtual_network.core.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [local.firewall_subnet_address_space]
  depends_on           = [azurerm_subnet.bastion]

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_subnet" "app_gw" {
  name                                          = "AppGwSubnet"
  virtual_network_name                          = azurerm_virtual_network.core.name
  resource_group_name                           = var.resource_group_name
  address_prefixes                              = [local.app_gw_subnet_address_prefix]
  private_endpoint_network_policies_enabled     = false
  private_link_service_network_policies_enabled = true
  depends_on                                    = [azurerm_subnet.azure_firewall]

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_subnet" "web_app" {
  name                                          = "WebAppSubnet"
  virtual_network_name                          = azurerm_virtual_network.core.name
  resource_group_name                           = var.resource_group_name
  address_prefixes                              = [local.web_app_subnet_address_prefix]
  private_endpoint_network_policies_enabled     = false
  private_link_service_network_policies_enabled = true
  depends_on                                    = [azurerm_subnet.app_gw]

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_subnet" "shared" {
  name                 = "SharedSubnet"
  virtual_network_name = azurerm_virtual_network.core.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [local.shared_services_subnet_address_prefix]
  # notice that private endpoints do not adhere to NSG rules
  private_endpoint_network_policies_enabled = false
  depends_on                                = [azurerm_subnet.web_app]

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_subnet" "resource_processor" {
  name                 = "ResourceProcessorSubnet"
  virtual_network_name = azurerm_virtual_network.core.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [local.resource_processor_subnet_address_prefix]
  # notice that private endpoints do not adhere to NSG rules
  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.ContainerRegistry"
  ]

  depends_on = [azurerm_subnet.shared]

  lifecycle { ignore_changes = [tags] }
}

resource "terraform_data" "resource_processor_network_rule" {
  provisioner "local-exec" {
    command = "az storage account network-rule add -g ${var.mgmt_resource_group_name} --account-name ${var.mgmt_storage_account_name} --subnet ${azurerm_subnet.resource_processor.id}"
  }

  triggers_replace = [
    azurerm_subnet.resource_processor.id
  ]

  depends_on = [azurerm_subnet.resource_processor]
}

resource "azurerm_subnet" "airlock_processor" {
  name                 = "AirlockProcessorSubnet"
  virtual_network_name = azurerm_virtual_network.core.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [local.airlock_processor_subnet_address_prefix]
  # notice that private endpoints do not adhere to NSG rules
  private_endpoint_network_policies_enabled = false
  depends_on                                = [azurerm_subnet.resource_processor]

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

  # Todo: needed as we want to open the fw for this subnet in some of the airlock storages (export inprogress)
  # https://github.com/microsoft/AzureTRE/issues/2098
  service_endpoints = ["Microsoft.Storage"]

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_subnet" "airlock_notification" {
  name                 = "AirlockNotifiactionSubnet"
  virtual_network_name = azurerm_virtual_network.core.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [local.airlock_notifications_subnet_address_prefix]
  # notice that private endpoints do not adhere to NSG rules
  private_endpoint_network_policies_enabled = false
  depends_on                                = [azurerm_subnet.airlock_processor]

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_subnet" "airlock_storage" {
  name                 = "AirlockStorageSubnet"
  virtual_network_name = azurerm_virtual_network.core.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [local.airlock_storage_subnet_address_prefix]
  # notice that private endpoints do not adhere to NSG rules
  private_endpoint_network_policies_enabled = false
  depends_on                                = [azurerm_subnet.airlock_notification]

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_subnet" "airlock_events" {
  name                 = "AirlockEventsSubnet"
  virtual_network_name = azurerm_virtual_network.core.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [local.airlock_events_subnet_address_prefix]
  # notice that private endpoints do not adhere to NSG rules
  private_endpoint_network_policies_enabled = false
  depends_on                                = [azurerm_subnet.airlock_storage]

  # Eventgrid CAN'T send messages over private endpoints, hence we need to allow service endpoints to the service bus
  # We are using service endpoints + managed identity to send these messaages
  # https://docs.microsoft.com/en-us/azure/event-grid/consume-private-endpoints
  service_endpoints = ["Microsoft.ServiceBus"]

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_subnet" "firewall_management" {
  count                = var.deploy_firewall ? 1 : 0
  name                 = "AzureFirewallManagementSubnet"
  virtual_network_name = azurerm_virtual_network.core.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [local.firewall_management_subnet_address_prefix]
  depends_on           = [azurerm_subnet.airlock_events]

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_ip_group" "resource_processor" {
  name                = "ipg-resource-processor"
  location            = var.location
  resource_group_name = var.resource_group_name
  cidrs               = [local.resource_processor_subnet_address_prefix]
  tags                = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_ip_group" "shared" {
  name                = "ipg-shared"
  location            = var.location
  resource_group_name = var.resource_group_name
  cidrs               = [local.shared_services_subnet_address_prefix]
  tags                = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_ip_group" "webapp" {
  name                = "ipg-web-app"
  location            = var.location
  resource_group_name = var.resource_group_name
  cidrs               = [local.web_app_subnet_address_prefix]
  tags                = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_ip_group" "airlock_processor" {
  name                = "ipg-airlock-processor"
  location            = var.location
  resource_group_name = var.resource_group_name
  cidrs               = [local.airlock_processor_subnet_address_prefix]
  tags                = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

module "terraform_azurerm_environment_configuration" {
  source          = "git::https://github.com/microsoft/terraform-azurerm-environment-configuration.git?ref=0.2.0"
  arm_environment = var.arm_environment
}
