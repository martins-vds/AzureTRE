# Create AVD DAG
resource "azurerm_virtual_desktop_application_group" "dag" {
  resource_group_name = var.resource_group_name
  location            = var.location
  host_pool_id        = data.azurerm_virtual_desktop_host_pool.hostpool.id
  type                = "Desktop"
  name                = "avg-dag-${local.workspace_resource_name_suffix}"
  friendly_name       = "Workspace ${local.short_workspace_id} Desktop Application Group"
  description         = "AVD application group"
  depends_on          = [azurerm_virtual_desktop_host_pool.hostpool, azurerm_virtual_desktop_workspace.workspace]
}

resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = local.avd_workspace
  resource_group_name = var.resource_group_name
  location            = var.location
  friendly_name       = "${local.workspace_resource_name_suffix} AVD Workspace"
  description         = "${local.workspace_resource_name_suffix} AVD Workspace"
}

# Associate Workspace and DAG
resource "azurerm_virtual_desktop_workspace_application_group_association" "ws-dag" {
  application_group_id = azurerm_virtual_desktop_application_group.dag.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
}

resource "azurerm_role_assignment" "avd_user" {
  count              = length(var.avd_users)
  scope              = azurerm_virtual_desktop_application_group.dag.id
  role_definition_id = data.azurerm_role_definition.desktop_virtualization_user.id
  principal_id       = var.avd_users[count.index]
}
