# Shared container registry
resource "azurerm_container_registry" "shared_acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.mgmt.name
  location            = azurerm_resource_group.mgmt.location
  sku                 = var.acr_sku
  admin_enabled       = true

  network_rule_bypass_option = "AzureServices"

  lifecycle { ignore_changes = [tags] }
}


# tredev is the devcontainer image name generate by our CICD
resource "azurerm_container_registry_task" "tredev_purge" {
  name                  = "tredev_purge"
  container_registry_id = azurerm_container_registry.shared_acr.id
  platform {
    os           = "Linux"
    architecture = "amd64"
  }
  encoded_step {
    task_content = <<EOF
version: v1.1.0
steps:
  - cmd: acr purge   --filter 'tredev:[0-9a-fA-F]{8}'   --ago 7d --untagged
    disableWorkingDirectoryOverride: true
    timeout: 600
EOF
  }

  timer_trigger {
    name     = "t1"
    schedule = "4 1 * * *"
    enabled  = true
  }
}

resource "azurerm_private_dns_zone" "azurecr" {
  count               = var.use_existing_private_dns_zone == true ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurecr.io"]
  resource_group_name = azurerm_resource_group.mgmt.name
  tags                = azurerm_resource_group.mgmt.tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "acrlink" {
  name                  = "acrmgmtlink"
  resource_group_name   = var.use_existing_private_dns_zone == true ? one(data.azurerm_private_dns_zone.azurecr[*].resource_group_name) : one(azurerm_private_dns_zone.azurecr[*].resource_group_name)
  private_dns_zone_name = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurecr.io"]
  virtual_network_id    = regex("(?P<virtual_network_id>.*)\\/subnets\\/(?P<subnet>.*)", var.mgmt_acr_private_endpoint_subnet_id).virtual_network_id
  tags                  = azurerm_resource_group.mgmt.tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_endpoint" "mgmt_acr_pe" {
  name                = "pe-mgmt-acr-devops-agents"
  location            = azurerm_container_registry.shared_acr.location
  resource_group_name = azurerm_container_registry.shared_acr.resource_group_name
  subnet_id           = var.mgmt_acr_private_endpoint_subnet_id
  tags                = azurerm_resource_group.mgmt.tags
  lifecycle { ignore_changes = [tags] }

  private_dns_zone_group {
    name                 = "private-dns-zone-group-mgmtacr"
    private_dns_zone_ids = [var.use_existing_private_dns_zone == true ? one(data.azurerm_private_dns_zone.azurecr[*].id) : one(azurerm_private_dns_zone.azurecr[*].id)]
  }

  private_service_connection {
    name                           = "psc-acr-mgmt"
    private_connection_resource_id = azurerm_container_registry.shared_acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }
}
