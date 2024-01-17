data "azurerm_private_dns_zone" "azurewebsites" {
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurewebsites.net"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "filecore" {
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.file.core.windows.net"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "blobcore" {
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.blob.core.windows.net"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "dfscore" {
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.dfs.core.windows.net"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "vaultcore" {
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.vaultcore.azure.net"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "azurecr" {
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.azurecr.io"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "azureml" {
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.api.azureml.ms"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "azuremlcert" {
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.cert.api.azureml.ms"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "notebooks" {
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.notebooks.azure.net"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "mysql" {
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.mysql.database.azure.com"]
  resource_group_name = var.private_dns_zone_resource_group_name
}

data "azurerm_private_dns_zone" "postgres" {
  name                = module.terraform_azurerm_environment_configuration.private_links["privatelink.postgres.database.azure.com"]
  resource_group_name = var.private_dns_zone_resource_group_name
}
