output "hostpool_name" {
  value = var.use_secondary_subscription == false ? one(azurerm_virtual_desktop_host_pool.hostpool_primary[*].name) : one(azurerm_virtual_desktop_host_pool.hostpool_secondary[*].name)
}

output "registration_info_token" {
  value = var.use_secondary_subscription == false ? one(azurerm_virtual_desktop_host_pool_registration_info.registrationinfo_primary[*].token) : one(azurerm_virtual_desktop_host_pool_registration_info.registrationinfo_secondary[*].token)
}

output "application_group_id" {
  value = var.use_secondary_subscription == false ? one(azurerm_virtual_desktop_application_group.dag_primary[*].id) : one(azurerm_virtual_desktop_application_group.dag_secondary[*].id)
}
