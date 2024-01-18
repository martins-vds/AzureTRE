variable "mgmt_storage_account_name" {
  type        = string
  description = "Storage account created by bootstrap to hold all Terraform state"
}

variable "mgmt_resource_group_name" {
  type        = string
  description = "Shared management resource group"
}

variable "mgmt_storage_allowed_subnet_ids" {
  type        = list(string)
  default     = []
  description = "Network rule set for storage account"
}

variable "location" {
  type        = string
  description = "Location used for all resources"
}

variable "arm_environment" {
  type        = string
  description = "ARM environment to deploy to"

}

variable "acr_sku" {
  type        = string
  default     = "Premium"
  description = "Price tier for ACR"
}

variable "acr_name" {
  type        = string
  description = "Name of ACR"
}

variable "mgmt_acr_private_endpoint_subnet_id" {
  type        = string
  default     = ""
  description = "Subnet ID for ACR private endpoint"
}

variable "mgmt_acr_allowed_networks" {
  type        = list(string)
  default     = []
  description = "Network rule set for ACR"
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

variable "secondary_arm_tenant_id" {
  type        = string
  default     = ""
  description = "Secondary ARM tenant ID"
}

variable "secondary_arm_subscription_id" {
  type        = string
  default     = ""
  description = "Secondary ARM subscription ID"
}

variable "secondary_arm_client_id" {
  type        = string
  default     = ""
  description = "Secondary ARM client ID"
}

variable "secondary_arm_client_secret" {
  type        = string
  default     = ""
  description = "Secondary ARM client secret"
  sensitive = true
}
