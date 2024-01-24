locals {
  tre_core_tags = {
    tre_id              = var.tre_id
    tre_core_service_id = var.tre_id
  }

  workspace = "avd-ws-${var.tre_id}"
  hostpool  = "avd-hp-${var.tre_id}"
  rfc3339   = timeadd(timestamp(), "720h")
  prefix    = "avd-${var.tre_id}"
}
