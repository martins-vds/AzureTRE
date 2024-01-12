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
