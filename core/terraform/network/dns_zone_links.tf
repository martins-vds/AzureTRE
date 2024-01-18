resource "azurerm_private_dns_zone_virtual_network_link" "azure_monitor" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "azure-monitor-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azure_monitor.name
  registration_enabled  = false
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azure_monitor_oms_opinsights" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "azure-monitor-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azure_monitor_oms_opinsights.name
  registration_enabled  = false
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azure_monitor_ods_opinsights" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "azure-monitor-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azure_monitor_ods_opinsights.name
  registration_enabled  = false
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azure_monitor_agentsvc" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "azure-monitor-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azure_monitor_agentsvc.name
  registration_enabled  = false
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "blobcore" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "blobcore-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.blobcore.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azurewebsites" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  resource_group_name   = var.private_dns_zone_resource_group_name
  virtual_network_id    = azurerm_virtual_network.core.id
  private_dns_zone_name = module.dns_zones.azurewebsites.name
  name                  = "azurewebsites-link"
  registration_enabled  = false
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "webcorelink" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "staticwebcore-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.static_web.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "filecorelink" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "filecore-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.filecore.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "vaultcore" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "vaultcore-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.vaultcore.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "acrlink" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "acrcore-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.azurecr.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "eventgridlink" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "eventgrid-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.eventgrid.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "tablelink" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "table-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.table.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "queuelink" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "queue-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.queue.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysqllink" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "mysql-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.mysql.name
  virtual_network_id    = azurerm_virtual_network.core.id
  registration_enabled  = false
  tags                  = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "servicebuslink" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "servicebus-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.servicebus.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "cosmoslink" {
  provider              = var.private_dns_zone_azure_credentials == "primary" ? azurerm : azurerm.secondary
  name                  = "cosmos-link"
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = module.dns_zones.cosmos.name
  virtual_network_id    = azurerm_virtual_network.core.id
  tags                  = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}
