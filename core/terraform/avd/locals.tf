locals {
  tre_core_tags = {
    tre_id              = var.tre_id
    tre_core_service_id = var.tre_id
  }

  workspace = "core-avd-ws-${var.tre_id}"
  hostpool  = "core-avd-hp-${var.tre_id}"
  rfc3339   = timeadd(timestamp(), "720h")
  prefix    = "core-avd-${var.tre_id}"
}
