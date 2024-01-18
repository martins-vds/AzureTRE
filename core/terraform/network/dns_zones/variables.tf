variable "tre_id" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "create_dns_zones" {
  type    = bool
  default = true
}
variable "arm_environment" {
  type = string
}
variable "provider" {
  type = string

  validation {
    condition     = contains(["primary", "secondary"], var.provider)
    error_message = "provider must be either primary or secondary"
  }
}
