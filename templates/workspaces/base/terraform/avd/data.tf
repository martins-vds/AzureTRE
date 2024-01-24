data "azurerm_virtual_desktop_host_pool" "core_hostpool" {
  name                = local.core_hostpool
  resource_group_name = local.core_resource_group_name
}

data "azurerm_role_definition" "desktop_virtualization_user" {
  name = "Desktop Virtualization User"
}
