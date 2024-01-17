terraform {
  # In modules we should only specify the min version
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.86.0"
    }
  }
}

module "dns_zones" {
  source              = "./dns_zones"
  create_dns_zones    = var.use_existing_private_dns_zone ? false : true
  resource_group_name = var.resource_group_name
  tre_id              = var.tre_id
}
