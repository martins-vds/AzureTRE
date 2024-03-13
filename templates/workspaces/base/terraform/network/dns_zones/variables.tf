variable "tre_id" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "use_primary_dns_zones" {
  type    = bool
  default = true
}
variable "arm_environment" {
  type = string
}
