resource "azurerm_private_dns_zone_virtual_network_link" "azure_monitor" {
  name                  = "azure-monitor-link"
  resource_group_name   = var.resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azure_monitor.name
  registration_enabled  = false
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azure_monitor_oms_opinsights" {
  name                  = "azure-monitor-link"
  resource_group_name   = var.resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azure_monitor_oms_opinsights.name
  registration_enabled  = false
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azure_monitor_ods_opinsights" {
  name                  = "azure-monitor-link"
  resource_group_name   = var.resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azure_monitor_ods_opinsights.name
  registration_enabled  = false
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azure_monitor_agentsvc" {
  name                  = "azure-monitor-link"
  resource_group_name   = var.resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azure_monitor_agentsvc.name
  registration_enabled  = false
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "blobcore" {
  name                  = "blobcorelink"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = module.dns_zones.blobcore.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azurewebsites" {
  resource_group_name   = var.resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azurewebsites.name
  name                  = "azurewebsites-link"
  registration_enabled  = false
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "webcorelink" {
  name                  = "staticwebcorelink"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = module.dns_zones.static_web.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "filecorelink" {
  name                  = "filecorelink"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = module.dns_zones.filecore.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "vaultcore" {
  name                  = "vaultcorelink"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = module.dns_zones.vaultcore.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "acrlink" {
  name                  = "acrcorelink"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = module.dns_zones.azurecr.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "eventgridlink" {
  name                  = "eventgrid-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = module.dns_zones.eventgrid.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "tablelink" {
  name                  = "table-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = module.dns_zones.table.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "queuelink" {
  name                  = "queue-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = module.dns_zones.queue.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}
