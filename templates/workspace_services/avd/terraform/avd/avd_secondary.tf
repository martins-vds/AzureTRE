# Create AVD workspace
resource "azurerm_virtual_desktop_workspace" "workspace_secondary" {
  provider            = azurerm.secondary
  count               = var.use_secondary_subscription ? 1 : 0
  name                = local.workspace
  resource_group_name = var.resource_group_name
  location            = var.location
  friendly_name       = "Workspace ${local.prefix}"
  description         = "Workspace ${local.prefix}"
}

# Create AVD host pool
resource "azurerm_virtual_desktop_host_pool" "hostpool_secondary" {
  provider                 = azurerm.secondary
  count                    = var.use_secondary_subscription ? 1 : 0
  resource_group_name      = var.resource_group_name
  location                 = var.location
  name                     = local.hostpool
  friendly_name            = local.hostpool
  validate_environment     = true
  custom_rdp_properties    = "audiocapturemode:i:1;audiomode:i:0;enablerdsaadauth:i:1;redirectclipboard:i:0;targetisaadjoined:i:1;"
  description              = "Azure TRE Workspace ${var.name} Host Pool"
  type                     = "Pooled"
  maximum_sessions_allowed = 16
  load_balancer_type       = "DepthFirst" #[BreadthFirst DepthFirst]

}

resource "azurerm_virtual_desktop_host_pool_registration_info" "registrationinfo_secondary" {
  provider        = azurerm.secondary
  count           = var.use_secondary_subscription ? 1 : 0
  hostpool_id     = one(azurerm_virtual_desktop_host_pool.hostpool_secondary[*].id)
  expiration_date = local.rfc3339
}

# Create AVD DAG
resource "azurerm_virtual_desktop_application_group" "dag_secondary" {
  provider                     = azurerm.secondary
  count                        = var.use_secondary_subscription ? 1 : 0
  resource_group_name          = var.resource_group_name
  location                     = var.location
  host_pool_id                 = one(azurerm_virtual_desktop_host_pool.hostpool_secondary[*].id)
  type                         = "Desktop"
  name                         = local.appgroup
  friendly_name                = "TRE Workspace Desktop Application Group"
  description                  = "AVD application group"
  default_desktop_display_name = "TRE Workspace - ${var.name}"
  depends_on = [
    one(azurerm_virtual_desktop_host_pool.hostpool_secondary[*]),
    one(azurerm_virtual_desktop_workspace.workspace_secondary[*])
  ]
}

# Associate Workspace and DAG
resource "azurerm_virtual_desktop_workspace_application_group_association" "ws-dag_secondary" {
  provider             = azurerm.secondary
  count                = var.use_secondary_subscription ? 1 : 0
  application_group_id = one(azurerm_virtual_desktop_application_group.dag_secondary[*].id)
  workspace_id         = one(azurerm_virtual_desktop_workspace.workspace_secondary[*].id)
}

resource "azurerm_key_vault_secret" "avd_registration_token_secondary" {
  provider     = azurerm.secondary
  count        = var.use_secondary_subscription ? 1 : 0
  name         = "registration-token-${var.name}"
  value        = one(azurerm_virtual_desktop_host_pool_registration_info.registrationinfo_secondary[*].token)
  key_vault_id = var.key_vault_id
  tags         = var.tags

  lifecycle { ignore_changes = [tags] }
}
