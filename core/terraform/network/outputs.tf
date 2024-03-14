output "core_vnet_id" {
  value = azurerm_virtual_network.core.id
}

output "bastion_subnet_id" {
  value = one(azurerm_subnet.bastion[*].id)
}

output "azure_firewall_subnet_id" {
  value = one(azurerm_subnet.azure_firewall[*].id)
}

output "app_gw_subnet_id" {
  value = azurerm_subnet.app_gw.id
}

output "web_app_subnet_id" {
  value = azurerm_subnet.web_app.id
}

output "shared_subnet_id" {
  value = azurerm_subnet.shared.id
}

output "airlock_processor_subnet_id" {
  value = azurerm_subnet.airlock_processor.id
}

output "airlock_storage_subnet_id" {
  value = azurerm_subnet.airlock_storage.id
}

output "airlock_events_subnet_id" {
  value = azurerm_subnet.airlock_events.id
}

output "resource_processor_subnet_id" {
  value = azurerm_subnet.resource_processor.id
}

# DNS Zones

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

output "blob_core_dns_zone_id" {
  value = module.dns_zones.blobcore.id
}

output "azurewebsites_dns_zone_id" {
  value = module.dns_zones.azurewebsites.id
}

output "static_web_dns_zone_id" {
  value = module.dns_zones.static_web.id
}

output "file_core_dns_zone_id" {
  value = module.dns_zones.filecore.id
}

output "queue_core_dns_zone_id" {
  value = module.dns_zones.queue.id
}

output "table_core_dns_zone_id" {
  value = module.dns_zones.table.id
}

output "servicebus_core_dns_zone_id" {
  value = module.dns_zones.servicebus.id
}

output "cosmos_core_dns_zone_id" {
  value = module.dns_zones.cosmos.id
}

output "mongo_core_dns_zone_id" {
  value = module.dns_zones.mongo.id
}

output "purview_core_dns_zone_id" {
  value = module.dns_zones.purview.id
}

output "purviewstudio_core_dns_zone_id" {
  value = module.dns_zones.purviewstudio.id
}

output "sql_core_dns_zone_id" {
  value = module.dns_zones.sql.id
}

output "dev_core_dns_zone_id" {
  value = module.dns_zones.dev.id
}

output "azuresynapse_core_dns_zone_id" {
  value = module.dns_zones.azuresynapse.id
}

output "dfs_core_dns_zone_id" {
  value = module.dns_zones.dfs.id
}

output "azurehealthcareapis_core_dns_zone_id" {
  value = module.dns_zones.azurehealthcareapis.id
}

output "dicom_core_dns_zone_id" {
  value = module.dns_zones.dicom.id
}

output "api_core_dns_zone_id" {
  value = module.dns_zones.api.id
}

output "cert_core_dns_zone_id" {
  value = module.dns_zones.cert.id
}

output "notebooks_core_dns_zone_id" {
  value = module.dns_zones.notebooks.id
}

output "postgres_core_dns_zone_id" {
  value = module.dns_zones.postgres.id
}

output "mysql_core_dns_zone_id" {
  value = module.dns_zones.mysql.id
}

output "azuredatabricks_core_dns_zone_id" {
  value = module.dns_zones.azuredatabricks.id
}

output "vaultcore_core_dns_zone_id" {
  value = module.dns_zones.vaultcore.id
}

output "eventgrid_core_dns_zone_id" {
  value = module.dns_zones.eventgrid.id
}
