output "app_role_workspace_owner_id" {
  value = random_uuid.app_role_workspace_owner_id.result
}

output "app_role_workspace_researcher_id" {
  value = random_uuid.app_role_workspace_researcher_id.result
}

output "app_role_workspace_airlock_manager_id" {
  value = random_uuid.app_role_workspace_airlock_manager_id.result
}

output "ws_group_workspace_airlock_managers_id" {
  value = azuread_group.workspace_airlock_managers.id
}

output "ws_group_workspace_researchers_id" {
  value = azuread_group.workspace_researchers.id
}

output "ws_group_workspace_owners_id" {
  value = azuread_group.workspace_owners.id
}

output "client_id" {
  value = azuread_application.workspace.application_id
}

output "scope_id" {
  value = "api://${var.workspace_resource_name_suffix}"
}

output "sp_id" {
  value = azuread_service_principal.workspace.object_id
}
