data "azurerm_resource_group" "core" {
  name = local.core_resource_group_name
}

data "azurerm_subnet" "bastion" {
  resource_group_name  = local.core_resource_group_name
  virtual_network_name = local.core_vnet
  name                 = "AzureBastionSubnet"
}
