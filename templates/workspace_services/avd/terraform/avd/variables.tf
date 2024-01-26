variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource group in which to deploy service objects"
}

variable "key_vault_id" {
  type = string
}

variable "tags" {
  type = map(string)
}
