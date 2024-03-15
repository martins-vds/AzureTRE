data "azurerm_virtual_network" "core" {
  name                = local.core_vnet
  resource_group_name = local.core_resource_group_name
}

data "azurerm_subnet" "core_webapps" {
  name                 = "WebAppSubnet"
  virtual_network_name = "vnet-${var.tre_id}"
  resource_group_name  = "rg-${var.tre_id}"
}

data "azurerm_subnet" "shared" {
  resource_group_name  = local.core_resource_group_name
  virtual_network_name = local.core_vnet
  name                 = "SharedSubnet"
}

data "azurerm_subnet" "bastion" {
  count                = var.bastion_deployed ? 1 : 0
  resource_group_name  = local.core_resource_group_name
  virtual_network_name = local.core_vnet
  name                 = "AzureBastionSubnet"
}

data "azurerm_subnet" "resourceprocessor" {
  resource_group_name  = local.core_resource_group_name
  virtual_network_name = local.core_vnet
  name                 = "ResourceProcessorSubnet"
}

data "azurerm_subnet" "airlockprocessor" {
  resource_group_name  = local.core_resource_group_name
  virtual_network_name = local.core_vnet
  name                 = "AirlockProcessorSubnet"
}

data "azurerm_route_table" "rt" {
  count               = var.enable_firewall ? 1 : 0
  name                = "rt-${var.tre_id}"
  resource_group_name = local.core_resource_group_name
}
