variable "tre_id" {
  type        = string
  description = "Unique TRE ID"
}

variable "workspace_id" {
  type = string
}

variable "tre_resource_id" {
  type        = string
  description = "Resource ID"
}

variable "image" {
  type = string
}
variable "vm_size" {
  type = string
}
variable "shared_storage_access" {
  type = bool
}
variable "shared_storage_name" {
  type = string
}
variable "image_gallery_id" {
  type    = string
  default = ""
}

variable "vm_users_object_id" {
  type    = string
  default = ""
}

variable "use_core_app_gateway" {
  type    = bool
  default = false
}

variable "avd_different_subscription" {
  type    = bool
  default = false
}

variable "avd_subscription_id" {
  type    = string
  default = ""
}

variable "avd_resource_group_name" {
  type    = string
  default = ""
}

variable "avd_vnet_name" {
  type    = string
  default = ""
}

variable "avd_subnet_name" {
  type    = string
  default = ""
}

variable "auth_tenant_id" {
  type        = string
  description = "Used to authenticate into the AAD Tenant to create the AAD App"
}
variable "auth_client_id" {
  type        = string
  description = "Used to authenticate into the AAD Tenant to create the AAD App"
}
variable "auth_client_secret" {
  type        = string
  description = "Used to authenticate into the AAD Tenant to create the AAD App"
}
