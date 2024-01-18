data "azurerm_private_dns_zone" "azure_monitor" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.monitor.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azure_monitor_oms_opinsights" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.oms.opinsights.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azure_monitor_ods_opinsights" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.ods.opinsights.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azure_monitor_agentsvc" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.agentsvc.azure-automation.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "blobcore" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.blob.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azurewebsites" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurewebsites.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "static_web" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.web.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "filecore" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.file.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "vaultcore" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.vaultcore.azure.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azurecr" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurecr.io"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "eventgrid" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.eventgrid.azure.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "table" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.table.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "queue" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.queue.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "servicebus" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.servicebus.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "cosmos" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.documents.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "mongo" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.mongo.cosmos.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "purview" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.purview.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "purviewstudio" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.purviewstudio.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "sql" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.sql.azuresynapse.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "dev" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.dev.azuresynapse.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azuresynapse" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azuresynapse.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "dfs" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.dfs.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azurehealthcareapis" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurehealthcareapis.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "dicom" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.dicom.azurehealthcareapis.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "api" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.api.azureml.ms"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "cert" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.cert.api.azureml.ms"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "notebooks" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.notebooks.azure.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "postgres" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.postgres.database.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "mysql" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.mysql.database.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azuredatabricks" {
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azuredatabricks.net"]
  resource_group_name = var.resource_group_name
}
