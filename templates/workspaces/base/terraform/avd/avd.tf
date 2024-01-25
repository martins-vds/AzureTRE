# Create AVD DAG
resource "azurerm_virtual_desktop_application_group" "dag" {
  resource_group_name = var.resource_group_name
  location            = var.location
  host_pool_id        = data.azurerm_virtual_desktop_host_pool.core_hostpool.id
  type                = "Desktop"
  name                = "avg-dag-${local.workspace_resource_name_suffix}"
  friendly_name       = "Workspace ${local.short_workspace_id} Desktop Application Group"
  description         = "AVD application group"
  default_desktop_display_name = "Workspace ${local.short_workspace_id}"
  depends_on          = [azurerm_virtual_desktop_workspace.workspace]
}

resource "azurerm_role_assignment" "avd_user" {
  count              = length(var.avd_users)
  scope              = azurerm_virtual_desktop_application_group.dag.id
  role_definition_id = data.azurerm_role_definition.desktop_virtualization_user.id
  principal_id       = var.avd_users[count.index]
}
