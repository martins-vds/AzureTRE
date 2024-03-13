data "azurerm_private_dns_zone" "azure_monitor_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.monitor.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azure_monitor_oms_opinsights_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.oms.opinsights.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azure_monitor_ods_opinsights_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.ods.opinsights.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azure_monitor_agentsvc_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.agentsvc.azure-automation.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "blobcore_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.blob.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azurewebsites_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurewebsites.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "static_web_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.web.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "filecore_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.file.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "vaultcore_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.vaultcore.azure.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azurecr_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurecr.io"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "eventgrid_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.eventgrid.azure.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "table_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.table.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "queue_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.queue.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "servicebus_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.servicebus.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "cosmos_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.documents.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "mongo_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.mongo.cosmos.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "purview_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.purview.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "purviewstudio_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.purviewstudio.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "sql_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.sql.azuresynapse.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "dev_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.dev.azuresynapse.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azuresynapse_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azuresynapse.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "dfs_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.dfs.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azurehealthcareapis_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurehealthcareapis.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "dicom_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.dicom.azurehealthcareapis.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "api_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.api.azureml.ms"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "cert_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.cert.api.azureml.ms"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "notebooks_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.notebooks.azure.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "postgres_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.postgres.database.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "mysql_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.mysql.database.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azuredatabricks_secondary" {
  provider            = azurerm.secondary
  count               = var.use_primary_dns_zones ? 0 : 1
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azuredatabricks.net"]
  resource_group_name = var.resource_group_name
}
