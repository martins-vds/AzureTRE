# Create AVD workspace
resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = local.workspace
  resource_group_name = var.resource_group_name
  location            = var.location
  friendly_name       = "Workspace ${local.prefix}"
  description         = "Workspace ${local.prefix}"
}

# Create AVD host pool
resource "azurerm_virtual_desktop_host_pool" "hostpool" {
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

resource "azurerm_virtual_desktop_scaling_plan" "hostpool-scaling-plan" {
  name                = "${local.hostpool}-scaling-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  friendly_name       = "${local.hostpool}-scaling-plan"
  description         = "${local.hostpool}-scaling-plan"
  time_zone           = "Eastern Standard Time"
  schedule {
    name                                 = "Weekdays"
    days_of_week                         = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    ramp_up_start_time                   = "05:00"
    ramp_up_load_balancing_algorithm     = "BreadthFirst"
    ramp_up_minimum_hosts_percent        = 20
    ramp_up_capacity_threshold_percent   = 10
    peak_start_time                      = "09:00"
    peak_load_balancing_algorithm        = "BreadthFirst"
    ramp_down_start_time                 = "19:00"
    ramp_down_load_balancing_algorithm   = "DepthFirst"
    ramp_down_minimum_hosts_percent      = 10
    ramp_down_force_logoff_users         = false
    ramp_down_wait_time_minutes          = 45
    ramp_down_notification_message       = "Please log off in the next 45 minutes..."
    ramp_down_capacity_threshold_percent = 5
    ramp_down_stop_hosts_when            = "ZeroSessions"
    off_peak_start_time                  = "22:00"
    off_peak_load_balancing_algorithm    = "DepthFirst"
  }
  host_pool {
    hostpool_id          = azurerm_virtual_desktop_host_pool.hostpool.id
    scaling_plan_enabled = true
  }
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
  name          = local.appgroup
  friendly_name = "TRE Workspace Desktop Application Group"
  description   = "AVD application group"
  default_desktop_display_name = "TRE Workspace - ${var.name}"
  depends_on    = [azurerm_virtual_desktop_host_pool.hostpool, azurerm_virtual_desktop_workspace.workspace]
}

# Associate Workspace and DAG
resource "azurerm_virtual_desktop_workspace_application_group_association" "ws-dag" {
  application_group_id = azurerm_virtual_desktop_application_group.dag.id
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
}

resource "azurerm_key_vault_secret" "avd_registration_token" {
  name         = "registration-token-${var.name}"
  value        = azurerm_virtual_desktop_host_pool_registration_info.registrationinfo.token
  key_vault_id = var.key_vault_id
  tags         = var.tags

  lifecycle { ignore_changes = [tags] }
}
