variable "workspace_id" {
  type = string
}
variable "tre_id" {
  type = string
}
variable "id" {
  type = string
}
variable "mgmt_resource_group_name" {
  type = string
}
variable "mgmt_acr_name" {
  type = string
}
variable "aad_authority_url" {
  type = string
}
variable "gitea_storage_limit" {
  type        = number
  description = "Space allocated in GB for the Gitea data in Azure Files Share"
  default     = 100
}
variable "shared_storage_name"{
  type = string
  validation {
    condition = length(var.shared_storage_name) > 0
    error_message = "shared_storage_name must be set"
  }
}
variable "arm_environment" {
  type = string
}

variable "use_core_private_dns_zones" {
  type        = bool
  description = "Use existing private DNS zone"
  default     = false
}

variable "private_dns_zones_resource_group_name" {
  type        = string
  description = "Resource group name of the private DNS zone"
  default     = ""
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
