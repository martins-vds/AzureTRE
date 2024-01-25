locals {
  core_resource_group_name       = "rg-${var.tre_id}"
  core_hostpool                  = "core-avd-hp-${var.tre_id}"
  core_workspace                 = "core-avd-ws-${var.tre_id}"
  short_workspace_id             = substr(var.tre_resource_id, -4, -1)
  workspace_resource_name_suffix = "${var.tre_id}-ws-${local.short_workspace_id}"
  avd_workspace                  = "avd-ws-${local.workspace_resource_name_suffix}"
  prefix                         = local.workspace_resource_name_suffix
}
