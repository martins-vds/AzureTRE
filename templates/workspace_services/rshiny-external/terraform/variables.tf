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
variable "image_repository"{
  type = string
  default = "microsoft/azuretre/rshiny-workspace-service-external"
  validation {
    condition = length(var.image_repository) > 0
    error_message = "Image repository cannot be empty"
  }
}
variable "image_tag"{
  type = string
  default = "latest"
  validation {
    condition = length(var.image_tag) > 0
    error_message = "Image tag cannot be empty"
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
