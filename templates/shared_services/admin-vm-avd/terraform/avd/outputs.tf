output "hostpool_name" {
  value = azurerm_virtual_desktop_host_pool.hostpool.name
}

output "registration_info_token" {
  value = azurerm_virtual_desktop_host_pool_registration_info.registrationinfo.token
}
