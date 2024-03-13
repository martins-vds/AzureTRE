resource "azurerm_private_dns_zone_virtual_network_link" "azurewebsites_secondary" {
  provider              = azurerm.secondary
  count                 = var.use_primary_dns_zones ? 0 : 1
  name                  = "azurewebsites-link-${azurerm_virtual_network.ws.name}-secondary"
  resource_group_name   = var.private_dns_zones_resource_group_name
  private_dns_zone_name = module.dns_zones.azurewebsites.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  registration_enabled  = false
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "filecorelink_secondary" {
  provider              = azurerm.secondary
  count                 = var.use_primary_dns_zones ? 0 : 1
  name                  = "filecorelink-${local.workspace_resource_name_suffix}-secondary"
  resource_group_name   = var.private_dns_zones_resource_group_name
  private_dns_zone_name = module.dns_zones.filecore.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "blobcorelink_secondary" {
  provider              = azurerm.secondary
  count                 = var.use_primary_dns_zones ? 0 : 1
  name                  = "blobcorelink-${local.workspace_resource_name_suffix}-secondary"
  resource_group_name   = var.private_dns_zones_resource_group_name
  private_dns_zone_name = module.dns_zones.blobcore.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "dfscorelink_secondary" {
  provider              = azurerm.secondary
  count                 = var.use_primary_dns_zones ? 0 : 1
  name                  = "dfscorelink-${local.workspace_resource_name_suffix}-secondary"
  resource_group_name   = var.private_dns_zones_resource_group_name
  private_dns_zone_name = module.dns_zones.dfs.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "vaultcorelink_secondary" {
  provider              = azurerm.secondary
  count                 = var.use_primary_dns_zones ? 0 : 1
  name                  = "vaultcorelink-${local.workspace_resource_name_suffix}-secondary"
  resource_group_name   = var.private_dns_zones_resource_group_name
  private_dns_zone_name = module.dns_zones.vaultcore.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azurecrlink_secondary" {
  provider              = azurerm.secondary
  count                 = var.use_primary_dns_zones ? 0 : 1
  name                  = "azurecrlink-${local.workspace_resource_name_suffix}-secondary"
  resource_group_name   = var.private_dns_zones_resource_group_name
  private_dns_zone_name = module.dns_zones.azurecr.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azuremllink_secondary" {
  provider              = azurerm.secondary
  count                 = var.use_primary_dns_zones ? 0 : 1
  name                  = "azuremllink-${local.workspace_resource_name_suffix}-secondary"
  resource_group_name   = var.private_dns_zones_resource_group_name
  private_dns_zone_name = module.dns_zones.azureml.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azuremlcertlink_secondary" {
  provider              = azurerm.secondary
  count                 = var.use_primary_dns_zones ? 0 : 1
  name                  = "azuremlcertlink-${local.workspace_resource_name_suffix}-secondary"
  resource_group_name   = var.private_dns_zones_resource_group_name
  private_dns_zone_name = module.dns_zones.azuremlcert.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "healthlink_secondary" {
  provider              = azurerm.secondary
  count                 = var.use_primary_dns_zones ? 0 : 1
  name                  = "healthlink-${local.workspace_resource_name_suffix}-secondary"
  resource_group_name   = var.private_dns_zones_resource_group_name
  private_dns_zone_name = module.dns_zones.health.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "dicomlink_secondary" {
  provider              = azurerm.secondary
  count                 = var.use_primary_dns_zones ? 0 : 1
  name                  = "dicomlink-${local.workspace_resource_name_suffix}-secondary"
  resource_group_name   = var.private_dns_zones_resource_group_name
  private_dns_zone_name = module.dns_zones.dicom.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "notebookslink_secondary" {
  provider              = azurerm.secondary
  count                 = var.use_primary_dns_zones ? 0 : 1
  name                  = "notebookslink-${local.workspace_resource_name_suffix}-secondary"
  resource_group_name   = var.private_dns_zones_resource_group_name
  private_dns_zone_name = module.dns_zones.notebooks.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysqllink_secondary" {
  provider              = azurerm.secondary
  count                 = var.use_primary_dns_zones ? 0 : 1
  name                  = "mysqllink-${local.workspace_resource_name_suffix}-secondary"
  resource_group_name   = var.private_dns_zones_resource_group_name
  private_dns_zone_name = module.dns_zones.mysql.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgreslink_secondary" {
  provider              = azurerm.secondary
  count                 = var.use_primary_dns_zones ? 0 : 1
  name                  = "postgreslink-${local.workspace_resource_name_suffix}-secondary"
  resource_group_name   = var.private_dns_zones_resource_group_name
  private_dns_zone_name = module.dns_zones.postgres.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

# resource "azurerm_private_dns_zone_virtual_network_link" "nexuslink_secondary" {
#   provider              = azurerm.secondary
#   count                 = var.use_primary_dns_zones ? 0 : 1
#   name                  = "nexuslink-${local.workspace_resource_name_suffix}-secondary"
#   resource_group_name   = var.private_dns_zones_resource_group_name
#   private_dns_zone_name = module.dns_zones.nexus.name
#   virtual_network_id    = azurerm_virtual_network.ws.id
#   tags                  = var.tre_workspace_tags

#   lifecycle { ignore_changes = [tags] }
# }

resource "azurerm_private_dns_zone_virtual_network_link" "databrickslink_secondary" {
  provider              = azurerm.secondary
  count                 = var.use_primary_dns_zones ? 0 : 1
  name                  = "databrickslink-${local.workspace_resource_name_suffix}-secondary"
  resource_group_name   = var.private_dns_zones_resource_group_name
  private_dns_zone_name = module.dns_zones.databricks.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}
