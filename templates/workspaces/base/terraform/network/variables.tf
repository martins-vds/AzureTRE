variable "location" {
  type = string
}
variable "tre_id" {
  type = string
}
variable "address_spaces" {
  type = string
}
variable "ws_resource_group_name" {
  type = string
}
variable "tre_workspace_tags" {
  type = map(string)
}
variable "tre_resource_id" {
  type = string
}
variable "arm_environment" {
  type = string
}
variable "enable_bastion" {
  type = bool
}
variable "enable_firewall" {
  type = bool
}
variable "use_primary_dns_zones" {
  type        = bool
  default     = false
  description = "Use existing private DNS zone for ACR"
}
variable "private_dns_zone_resource_group_name" {
  type        = string
  default     = ""
  description = "Resource group of private DNS zone for ACR"
}
