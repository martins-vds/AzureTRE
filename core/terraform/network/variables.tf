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
variable "mgmt_storage_account_name" {
  type        = string
  description = "Storage account created by bootstrap to hold all Terraform state"
}
variable "mgmt_resource_group_name" {
  type        = string
  description = "Shared management resource group"
}
variable "mgmt_acr_name" {
  type        = string
  description = "value of the mgmt acr name"
}
variable "use_core_private_dns_zones" {
  type        = bool
  default     = false
  description = "Use existing private DNS zone for ACR"
}
variable "private_dns_zones_resource_group_name" {
  type        = string
  default     = ""
  description = "Resource group of private DNS zone for ACR"
}
variable "ddos_plan_id" {
  type        = string
  description = "DDOS plan ID"

  validation {
    condition     = var.ddos_plan_id != ""
    error_message = "DDOS plan ID must be specified"
  }
}

variable "deploy_bastion" {
  type        = bool
  default     = false
  description = "Deploy a bastion host in the mgmt resource group"
}
