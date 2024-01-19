resource "azurerm_private_dns_zone_virtual_network_link" "azure_monitor" {
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  provider              = azurerm.primary
  name                  = "azure-monitor-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azure_monitor.name
  registration_enabled  = false
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azure_monitor_oms_opinsights" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "azure-monitor-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azure_monitor_oms_opinsights.name
  registration_enabled  = false
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azure_monitor_ods_opinsights" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "azure-monitor-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azure_monitor_ods_opinsights.name
  registration_enabled  = false
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azure_monitor_agentsvc" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "azure-monitor-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azure_monitor_agentsvc.name
  registration_enabled  = false
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "blobcore" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "blobcore-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.blobcore.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azurewebsites" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "azurewebsites-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azurewebsites.name
  registration_enabled  = false
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "webcorelink" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "staticwebcore-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.static_web.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "filecorelink" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "filecore-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.filecore.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "vaultcore" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "vaultcore-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.vaultcore.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "acrlink" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "acrcore-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.azurecr.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "eventgridlink" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "eventgrid-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.eventgrid.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "tablelink" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "table-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.table.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "queuelink" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "queue-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.queue.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysqllink" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "mysql-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.mysql.name
  virtual_network_id    = azurerm_virtual_network.core.id
  registration_enabled  = false
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "servicebuslink" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "servicebus-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.servicebus.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "cosmoslink" {
  provider              = azurerm.primary
  count                 = var.use_existing_private_dns_zone ? 0 : 1
  name                  = "cosmos-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.cosmos.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}
