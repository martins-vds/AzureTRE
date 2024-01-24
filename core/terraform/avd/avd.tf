# Create AVD workspace
resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = local.workspace
  resource_group_name = var.resource_group_name
  location            = var.location
  friendly_name       = "${local.prefix} Workspace"
  description         = "${local.prefix} Workspace"
}

# Create AVD host pool
resource "azurerm_virtual_desktop_host_pool" "hostpool" {
  resource_group_name      = var.resource_group_name
  location                 = var.location
  name                     = local.hostpool
  friendly_name            = local.hostpool
  validate_environment     = true
  custom_rdp_properties    = "audiocapturemode:i:1;audiomode:i:0;"
  description              = "${local.prefix} Azure TRE HostPool"
  type                     = "Pooled"
  maximum_sessions_allowed = 16
  load_balancer_type       = "DepthFirst" #[BreadthFirst DepthFirst]
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registrationinfo" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.hostpool.id
  expiration_date = local.rfc3339
}

# Create AVD DAG
resource "azurerm_virtual_desktop_application_group" "dag" {
  resource_group_name = var.resource_group_name
  location            = var.location
  host_pool_id        = azurerm_virtual_desktop_host_pool.hostpool.id
  type          = "Desktop"
  name          = "${local.prefix}-dag"
  friendly_name = "Azure TRE Desktop Application Group"
  description   = "AVD application group"
  depends_on    = [azurerm_virtual_desktop_host_pool.hostpool, azurerm_virtual_desktop_workspace.workspace]
}

# Associate Workspace and DAG
resource "azurerm_virtual_desktop_workspace_application_group_association" "ws-dag" {
  application_group_id = azurerm_virtual_desktop_application_group.dag.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
}

resource "azurerm_key_vault_secret" "avd_registration_token" {
  name         = "avd-registration-token"
  value        = azurerm_virtual_desktop_host_pool_registration_info.registrationinfo.token
  key_vault_id = var.key_vault_id
  tags         = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }
}