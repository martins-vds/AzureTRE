variable "workspace_id" {
  type        = string
  description = "The workspace ID"
}
variable "aad_authority_url" {
  type        = string
  description = "The Azure AD authority URL"
}
variable "tre_id" {
  type        = string
  description = "The TRE ID"
}
variable "mgmt_resource_group_name" {
  type        = string
  description = "The management resource group name"
}
variable "mgmt_acr_name" {
  type        = string
  description = "The management ACR name"
}

variable "bastion_scale_units" {
  type        = number
  description = "The number of bastion scale units"
}

variable "bastion_disable_copy" {
  type        = bool
  description = "Disable copy from the Guacamole workspace"
}
variable "bastion_disable_paste" {
  type        = bool
  description = "Disable paste to the Guacamole workspace"
}
variable "bastion_enable_drive" {
  type        = bool
  description = "Enable drive redirection"
}
variable "bastion_drive_name" {
  type        = string
  description = "The drive name"
}
variable "bastion_drive_path" {
  type        = string
  description = "The drive path"
}
variable "bastion_disable_download" {
  type        = bool
  description = "Disable download from the Guacamole workspace"
}
variable "bastion_disable_upload" {
  type        = bool
  description = "Disable upload to the Guacamole workspace"
}
variable "is_exposed_externally" {
  type        = bool
  description = "Is the Guacamole workspace to be exposed externally?"
}
variable "tre_resource_id" {
  type        = string
  description = "The workspace service ID"
}
variable "arm_environment" {
  type        = string
  description = "The ARM cloud environment"
}
