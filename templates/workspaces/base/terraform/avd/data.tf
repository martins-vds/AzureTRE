data "azurerm_resource_group" "core_resource_group" {
  name = local.core_resource_group_name
}

data "azurerm_virtual_desktop_host_pool" "core_hostpool" {
  name                = local.core_hostpool
  resource_group_name = local.core_resource_group_name
}

data "azapi_resource_id" "core_workspace"{
  type = "Microsoft.DesktopVirtualization/workspaces@2022-02-10-preview"
  name = local.core_workspace
  parent_id = data.azurerm_resource_group.core_resource_group.id
}

data "azurerm_role_definition" "desktop_virtualization_user" {
  name = "Desktop Virtualization User"
}
