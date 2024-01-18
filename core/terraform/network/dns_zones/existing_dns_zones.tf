data "azurerm_private_dns_zone" "azure_monitor" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.monitor.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azure_monitor_oms_opinsights" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.oms.opinsights.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azure_monitor_ods_opinsights" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.ods.opinsights.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azure_monitor_agentsvc" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.agentsvc.azure-automation.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "blobcore" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.blob.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azurewebsites" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurewebsites.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "static_web" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.web.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "filecore" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.file.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "vaultcore" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.vaultcore.azure.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azurecr" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurecr.io"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "eventgrid" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.eventgrid.azure.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "table" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.table.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "queue" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.queue.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "servicebus" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.servicebus.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "cosmos" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.documents.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "mongo" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.mongo.cosmos.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "purview" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.purview.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "purviewstudio" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.purviewstudio.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "sql" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.sql.azuresynapse.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "dev" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.dev.azuresynapse.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azuresynapse" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azuresynapse.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "dfs" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.dfs.core.windows.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azurehealthcareapis" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurehealthcareapis.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "dicom" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.dicom.azurehealthcareapis.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "api" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.api.azureml.ms"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "cert" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.cert.api.azureml.ms"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "notebooks" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.notebooks.azure.net"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "postgres" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.postgres.database.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "mysql" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.mysql.database.azure.com"]
  resource_group_name = var.resource_group_name
}

data "azurerm_private_dns_zone" "azuredatabricks" {
  provider            = var.provider == "primary" ? azurerm : azurerm.secondary
  count               = var.create_dns_zones == false ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azuredatabricks.net"]
  resource_group_name = var.resource_group_name
}
