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
}
variable "private_dns_zone_azure_credentials"{
  type        = string
  default     = "secondary"
  description = "Azure credentials for private DNS zone for ACR"

  validation {
    condition = contains(["primary", "secondary"], var.private_dns_zone_azure_credentials)
    error_message = "private_dns_zone_azure_credentials must be either primary or secondary"
  }
}
