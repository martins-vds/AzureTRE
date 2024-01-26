data "azurerm_subnet" "shared" {
  resource_group_name  = local.core_resource_group_name
  virtual_network_name = local.core_vnet
  name                 = "SharedSubnet"
}

data "azurerm_key_vault" "keyvault" {
  name                = local.keyvault_name
  resource_group_name = local.core_resource_group_name
}

data "azurerm_resource_group" "rg" {
  name = local.core_resource_group_name
}

data "azurerm_log_analytics_workspace" "oms-workspace" {
  name = local.law_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_virtual_desktop_host_pool" "core_hostpool" {
  name                = local.core_hostpool
  resource_group_name = local.core_resource_group_name
}

data "azurerm_key_vault_secret" "avd_registration_token" {
  name = "avd-registration-token"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}
