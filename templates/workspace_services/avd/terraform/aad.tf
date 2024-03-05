# Assign roles to the application group

resource "azurerm_role_assignment" "desktop_virtualization_user_airlock_managers" {
  provider           = azurerm.avdsubscription
  scope              = module.avd.application_group_id
  role_definition_id = data.azurerm_role_definition.desktop_virtualization_user.id
  principal_id       = data.azuread_group.workspace_airlock_managers.id
}

resource "azurerm_role_assignment" "desktop_virtualization_user_workspace_researchers" {
  provider           = azurerm.avdsubscription
  scope              = module.avd.application_group_id
  role_definition_id = data.azurerm_role_definition.desktop_virtualization_user.id
  principal_id       = data.azuread_group.workspace_researchers.id
}

resource "azurerm_role_assignment" "desktop_virtualization_user_workspace_owners" {
  provider           = azurerm.avdsubscription
  scope              = module.avd.application_group_id
  role_definition_id = data.azurerm_role_definition.desktop_virtualization_user.id
  principal_id       = data.azuread_group.workspace_owners.id
}

# Assign roles to the host pool

resource "azurerm_role_assignment" "virtual_machine_user_login_airlock_managers" {
  provider           = azurerm.avdsubscription
  scope              = azurerm_windows_virtual_machine.session_host.id
  role_definition_id = data.azurerm_role_definition.virtual_machine_user_login.id
  principal_id       = data.azuread_group.workspace_airlock_managers.id
}

resource "azurerm_role_assignment" "virtual_machine_user_login_workspace_researchers" {
  provider           = azurerm.avdsubscription
  scope              = azurerm_windows_virtual_machine.session_host.id
  role_definition_id = data.azurerm_role_definition.virtual_machine_user_login.id
  principal_id       = data.azuread_group.workspace_researchers.id
}

resource "azurerm_role_assignment" "virtual_machine_admin_login_workspace_owners" {
  provider           = azurerm.avdsubscription
  scope              = azurerm_windows_virtual_machine.session_host.id
  role_definition_id = data.azurerm_role_definition.virtual_machine_admin_login.id
  principal_id       = data.azuread_group.workspace_owners.id
}
