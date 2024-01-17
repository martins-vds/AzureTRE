data "azurerm_private_dns_zone" "azurewebsites" {
  count = var.use_existing_private_dns_zone == true ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurewebsites.net"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "filecore" {
  count = var.use_existing_private_dns_zone == true ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.file.core.windows.net"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "blobcore" {
  count = var.use_existing_private_dns_zone == true ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.blob.core.windows.net"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "dfscore" {
  count = var.use_existing_private_dns_zone == true ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.dfs.core.windows.net"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "vaultcore" {
  count = var.use_existing_private_dns_zone == true ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.vaultcore.azure.net"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "azurecr" {
  count = var.use_existing_private_dns_zone == true ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurecr.io"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "azureml" {
  count = var.use_existing_private_dns_zone == true ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.api.azureml.ms"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "azuremlcert" {
  count = var.use_existing_private_dns_zone == true ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.cert.api.azureml.ms"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "notebooks" {
  count = var.use_existing_private_dns_zone == true ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.notebooks.azure.net"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "mysql" {
  count = var.use_existing_private_dns_zone == true ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.mysql.database.azure.com"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "postgres" {
  count = var.use_existing_private_dns_zone == true ? 1 : 0
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.postgres.database.azure.com"]
  resource_group_name = var.private_dns_zone_resource_group_name
}
