resource "azurerm_private_dns_zone_virtual_network_link" "azurewebsites" {
  provider              = azurerm.primary
  count                 = var.use_primary_dns_zones ? 1 : 0
  name                  = "azurewebsites-link-${azurerm_virtual_network.ws.name}"
  resource_group_name   = local.core_resource_group_name
  private_dns_zone_name = module.dns_zones.azurewebsites.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  registration_enabled  = false
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "filecorelink" {
  provider              = azurerm.primary
  count                 = var.use_primary_dns_zones ? 1 : 0
  name                  = "filecorelink-${local.workspace_resource_name_suffix}"
  resource_group_name   = local.core_resource_group_name
  private_dns_zone_name = module.dns_zones.filecore.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "blobcorelink" {
  provider              = azurerm.primary
  count                 = var.use_primary_dns_zones ? 1 : 0
  name                  = "blobcorelink-${local.workspace_resource_name_suffix}"
  resource_group_name   = local.core_resource_group_name
  private_dns_zone_name = module.dns_zones.blobcore.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "dfscorelink" {
  provider              = azurerm.primary
  count                 = var.use_primary_dns_zones ? 1 : 0
  name                  = "dfscorelink-${local.workspace_resource_name_suffix}"
  resource_group_name   = local.core_resource_group_name
  private_dns_zone_name = module.dns_zones.dfs.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "vaultcorelink" {
  provider              = azurerm.primary
  count                 = var.use_primary_dns_zones ? 1 : 0
  name                  = "vaultcorelink-${local.workspace_resource_name_suffix}"
  resource_group_name   = local.core_resource_group_name
  private_dns_zone_name = module.dns_zones.vaultcore.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azurecrlink" {
  provider              = azurerm.primary
  count                 = var.use_primary_dns_zones ? 1 : 0
  name                  = "azurecrlink-${local.workspace_resource_name_suffix}"
  resource_group_name   = local.core_resource_group_name
  private_dns_zone_name = module.dns_zones.azurecr.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azuremllink" {
  provider              = azurerm.primary
  count                 = var.use_primary_dns_zones ? 1 : 0
  name                  = "azuremllink-${local.workspace_resource_name_suffix}"
  resource_group_name   = local.core_resource_group_name
  private_dns_zone_name = module.dns_zones.azureml.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "azuremlcertlink" {
  provider              = azurerm.primary
  count                 = var.use_primary_dns_zones ? 1 : 0
  name                  = "azuremlcertlink-${local.workspace_resource_name_suffix}"
  resource_group_name   = local.core_resource_group_name
  private_dns_zone_name = module.dns_zones.azuremlcert.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "healthlink" {
  provider              = azurerm.primary
  count                 = var.use_primary_dns_zones ? 1 : 0
  name                  = "healthlink-${local.workspace_resource_name_suffix}"
  resource_group_name   = local.core_resource_group_name
  private_dns_zone_name = module.dns_zones.health.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "dicomlink" {
  provider              = azurerm.primary
  count                 = var.use_primary_dns_zones ? 1 : 0
  name                  = "dicomlink-${local.workspace_resource_name_suffix}"
  resource_group_name   = local.core_resource_group_name
  private_dns_zone_name = module.dns_zones.dicom.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "notebookslink" {
  provider              = azurerm.primary
  count                 = var.use_primary_dns_zones ? 1 : 0
  name                  = "notebookslink-${local.workspace_resource_name_suffix}"
  resource_group_name   = local.core_resource_group_name
  private_dns_zone_name = module.dns_zones.notebooks.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "mysqllink" {
  provider              = azurerm.primary
  count                 = var.use_primary_dns_zones ? 1 : 0
  name                  = "mysqllink-${local.workspace_resource_name_suffix}"
  resource_group_name   = local.core_resource_group_name
  private_dns_zone_name = module.dns_zones.mysql.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_private_dns_zone_virtual_network_link" "postgreslink" {
  provider              = azurerm.primary
  count                 = var.use_primary_dns_zones ? 1 : 0
  name                  = "postgreslink-${local.workspace_resource_name_suffix}"
  resource_group_name   = local.core_resource_group_name
  private_dns_zone_name = module.dns_zones.postgres.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}

# resource "azurerm_private_dns_zone_virtual_network_link" "nexuslink" {
#   provider              = azurerm.primary
#   count                 = var.use_primary_dns_zones ? 1 : 0
#   name                  = "nexuslink-${local.workspace_resource_name_suffix}"
#   resource_group_name   = local.core_resource_group_name
#   private_dns_zone_name = module.dns_zones.nexus.name
#   virtual_network_id    = azurerm_virtual_network.ws.id
#   tags                  = var.tre_workspace_tags

#   lifecycle { ignore_changes = [tags] }
# }

resource "azurerm_private_dns_zone_virtual_network_link" "databrickslink" {
  provider              = azurerm.primary
  count                 = var.use_primary_dns_zones ? 1 : 0
  name                  = "databrickslink-${local.workspace_resource_name_suffix}"
  resource_group_name   = local.core_resource_group_name
  private_dns_zone_name = module.dns_zones.databricks.name
  virtual_network_id    = azurerm_virtual_network.ws.id
  tags                  = var.tre_workspace_tags

  lifecycle { ignore_changes = [tags] }
}
