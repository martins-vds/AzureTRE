output "vnet_id" {
  value = azurerm_virtual_network.ws.id
}

output "services_subnet_id" {
  value = azurerm_subnet.services.id
}

output "vaultcore_zone_id" {
  value = module.dns_zones.vaultcore.id
}

output "filecore_zone_id" {
  value = module.dns_zones.filecore.id
}

output "blobcore_zone_id" {
  value = module.dns_zones.blobcore.id
}

output "dfscore_zone_id" {
  value = module.dns_zones.dfscore.id
}

output "airlock_processor_subnet_id" {
  value = data.azurerm_subnet.airlockprocessor.id
}

output "azure_monitor_dns_zone_id" {
  value = module.dns_zones.azure_monitor.id
}

output "azure_monitor_oms_opinsights_dns_zone_id" {
  value = module.dns_zones.azure_monitor_oms_opinsights.id
}

output "azure_monitor_ods_opinsights_dns_zone_id" {
  value = module.dns_zones.azure_monitor_ods_opinsights.id
}

output "azure_monitor_agentsvc_dns_zone_id" {
  value = module.dns_zones.azure_monitor_agentsvc.id
}

