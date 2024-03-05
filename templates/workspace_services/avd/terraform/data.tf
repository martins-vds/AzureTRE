data "azurerm_resource_group" "ws" {
  name = "rg-${var.tre_id}-ws-${local.short_workspace_id}"
}

data "azurerm_resource_group" "core" {
  name = "rg-${var.tre_id}"
}

data "azurerm_resource_group" "avd" {
  count    = var.avd_different_subscription ? 1 : 0
  provider = azurerm.avdsubscription
  name     = var.avd_resource_group_name
}

data "azurerm_virtual_network" "ws" {
  name                = "vnet-${var.tre_id}-ws-${local.short_workspace_id}"
  resource_group_name = data.azurerm_resource_group.ws.name
}

data "azurerm_virtual_network" "avd" {
  count               = var.avd_different_subscription ? 1 : 0
  provider            = azurerm.avdsubscription
  name                = var.avd_vnet_name
  resource_group_name = one(data.azurerm_resource_group.avd[*].name)
}

data "azurerm_subnet" "services" {
  name                 = "ServicesSubnet"
  virtual_network_name = data.azurerm_virtual_network.ws.name
  resource_group_name  = data.azurerm_resource_group.ws.name
}

data "azurerm_subnet" "avd" {
  count                = var.avd_different_subscription ? 1 : 0
  provider             = azurerm.avdsubscription
  name                 = var.avd_subnet_name
  virtual_network_name = one(data.azurerm_virtual_network.avd[*].name)
  resource_group_name  = one(data.azurerm_resource_group.avd[*].name)
}

data "azurerm_key_vault" "ws" {
  name                = local.keyvault_name
  resource_group_name = data.azurerm_resource_group.ws.name
}

data "azurerm_public_ip" "app_gateway_ip" {
  count               = var.use_core_app_gateway ? 1 : 0
  name                = "pip-agw-${var.tre_id}"
  resource_group_name = data.azurerm_resource_group.core.name
}

data "azurerm_storage_account" "stg" {
  name                = local.storage_name
  resource_group_name = data.azurerm_resource_group.ws.name
}

data "azurerm_storage_share" "shared_storage" {
  count                = var.shared_storage_access ? 1 : 0
  name                 = var.shared_storage_name
  storage_account_name = data.azurerm_storage_account.stg.name
}

data "azurerm_log_analytics_workspace" "oms-workspace" {
  name                = local.law_name
  resource_group_name = data.azurerm_resource_group.core.name
}

data "azurerm_role_definition" "desktop_virtualization_user" {
  provider = azurerm.avdsubscription
  name     = "Desktop Virtualization User"
}

data "azurerm_role_definition" "virtual_machine_user_login" {
  provider = azurerm.avdsubscription
  name     = "Virtual Machine User Login"
}

data "azurerm_role_definition" "virtual_machine_admin_login" {
  provider = azurerm.avdsubscription
  name     = "Virtual Machine Administrator Login"
}

data "azuread_group" "workspace_owners" {
  display_name     = "${local.workspace_resource_name_suffix} Workspace Owners"
  security_enabled = true
}

data "azuread_group" "workspace_researchers" {
  display_name     = "${local.workspace_resource_name_suffix} Workspace Researchers"
  security_enabled = true
}

data "azuread_group" "workspace_airlock_managers" {
  display_name     = "${local.workspace_resource_name_suffix} Airlock Managers"
  security_enabled = true
}
