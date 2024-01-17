variable "tre_id" {
  type = string
}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "core_address_space" {
  type = string
}
variable "arm_environment" {
  type = string
}
variable "enable_bastion" {
  type    = bool
  default = false
}
variable "mgmt_storage_account_name" {
  type        = string
  description = "Storage account created by bootstrap to hold all Terraform state"
}
variable "mgmt_resource_group_name" {
  type        = string
  description = "Shared management resource group"
}
variable "mgmt_acr_name" {
  type = string
  description = "value of the mgmt acr name"
}
variable "use_existing_private_dns_zone" {
  type        = bool
  default     = false
  description = "Use existing private DNS zone for ACR"
}
variable "private_dns_zone_resource_group_name" {
  type        = string
  default     = ""
  description = "Resource group of private DNS zone for ACR"

  validation {
    condition     = var.use_existing_private_dns_zone == true && var.private_dns_zone_resource_group_name == ""
    error_message = "private_dns_zone_resource_group_name must be specified when use_existing_private_dns_zone is true"
  }
}
