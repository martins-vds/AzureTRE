data "azurerm_storage_account" "mgmt_stg" {
  name                = var.mgmt_storage_account_name
  resource_group_name = var.mgmt_resource_group_name
}

data "azurerm_container_registry" "mgmt_acr" {
  name                = var.mgmt_acr_name
  resource_group_name = var.mgmt_resource_group_name
}
