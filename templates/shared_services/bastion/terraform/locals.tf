locals {
  core_resource_group_name = "rg-${var.tre_id}"
  core_vnet                = "vnet-${var.tre_id}"
  tre_shared_service_tags = {
    tre_id                = var.tre_id
    tre_shared_service_id = var.tre_resource_id
  }
}
