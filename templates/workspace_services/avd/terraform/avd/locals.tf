locals {
  workspace = "avd-ws-${var.name}"
  hostpool  = "avd-hp-${var.name}"
  appgroup  = "avd-ag-${var.name}"
  prefix    = "avd-${var.name}"
  rfc3339   = timeadd(timestamp(), "480h")
}
