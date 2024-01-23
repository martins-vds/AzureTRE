output "azure_monitor" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azure_monitor[*].name) : one(data.azurerm_private_dns_zone.azure_monitor_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azure_monitor[*].id) : one(data.azurerm_private_dns_zone.azure_monitor_secondary[*].id)
  }
}

output "azure_monitor_oms_opinsights" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azure_monitor_oms_opinsights[*].name) : one(data.azurerm_private_dns_zone.azure_monitor_oms_opinsights_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azure_monitor_oms_opinsights[*].id) : one(data.azurerm_private_dns_zone.azure_monitor_oms_opinsights_secondary[*].id)
  }
}

output "azure_monitor_ods_opinsights" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azure_monitor_ods_opinsights[*].name) : one(data.azurerm_private_dns_zone.azure_monitor_ods_opinsights_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azure_monitor_ods_opinsights[*].id) : one(data.azurerm_private_dns_zone.azure_monitor_ods_opinsights_secondary[*].id)
  }
}

output "azure_monitor_agentsvc" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azure_monitor_agentsvc[*].name) : one(data.azurerm_private_dns_zone.azure_monitor_agentsvc_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azure_monitor_agentsvc[*].id) : one(data.azurerm_private_dns_zone.azure_monitor_agentsvc_secondary[*].id)
  }
}

output "blobcore" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.blobcore[*].name) : one(data.azurerm_private_dns_zone.blobcore_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.blobcore[*].id) : one(data.azurerm_private_dns_zone.blobcore_secondary[*].id)
  }
}

output "azurewebsites" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azurewebsites[*].name) : one(data.azurerm_private_dns_zone.azurewebsites_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azurewebsites[*].id) : one(data.azurerm_private_dns_zone.azurewebsites_secondary[*].id)
  }
}

output "static_web" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.static_web[*].name) : one(data.azurerm_private_dns_zone.static_web_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.static_web[*].id) : one(data.azurerm_private_dns_zone.static_web_secondary[*].id)
  }
}

output "filecore" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.filecore[*].name) : one(data.azurerm_private_dns_zone.filecore_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.filecore[*].id) : one(data.azurerm_private_dns_zone.filecore_secondary[*].id)
  }
}

output "vaultcore" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.vaultcore[*].name) : one(data.azurerm_private_dns_zone.vaultcore_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.vaultcore[*].id) : one(data.azurerm_private_dns_zone.vaultcore_secondary[*].id)
  }
}

output "azurecr" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azurecr[*].name) : one(data.azurerm_private_dns_zone.azurecr_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azurecr[*].id) : one(data.azurerm_private_dns_zone.azurecr_secondary[*].id)
  }
}

output "eventgrid" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.eventgrid[*].name) : one(data.azurerm_private_dns_zone.eventgrid_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.eventgrid[*].id) : one(data.azurerm_private_dns_zone.eventgrid_secondary[*].id)
  }
}

output "table" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.table[*].name) : one(data.azurerm_private_dns_zone.table_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.table[*].id) : one(data.azurerm_private_dns_zone.table_secondary[*].id)
  }
}

output "queue" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.queue[*].name) : one(data.azurerm_private_dns_zone.queue_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.queue[*].id) : one(data.azurerm_private_dns_zone.queue_secondary[*].id)
  }
}

output "servicebus" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.servicebus[*].name) : one(data.azurerm_private_dns_zone.servicebus_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.servicebus[*].id) : one(data.azurerm_private_dns_zone.servicebus_secondary[*].id)
  }
}

output "cosmos" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.cosmos[*].name) : one(data.azurerm_private_dns_zone.cosmos_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.cosmos[*].id) : one(data.azurerm_private_dns_zone.cosmos_secondary[*].id)
  }
}

output "mongo" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.mongo[*].name) : one(data.azurerm_private_dns_zone.mongo_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.mongo[*].id) : one(data.azurerm_private_dns_zone.mongo_secondary[*].id)
  }
}

output "purview" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.purview[*].name) : one(data.azurerm_private_dns_zone.purview_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.purview[*].id) : one(data.azurerm_private_dns_zone.purview_secondary[*].id)
  }
}

output "purviewstudio" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.purviewstudio[*].name) : one(data.azurerm_private_dns_zone.purviewstudio_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.purviewstudio[*].id) : one(data.azurerm_private_dns_zone.purviewstudio_secondary[*].id)
  }
}

output "sql" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.sql[*].name) : one(data.azurerm_private_dns_zone.sql_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.sql[*].id) : one(data.azurerm_private_dns_zone.sql_secondary[*].id)
  }
}

output "dev" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.dev[*].name) : one(data.azurerm_private_dns_zone.dev_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.dev[*].id) : one(data.azurerm_private_dns_zone.dev_secondary[*].id)
  }
}

output "azuresynapse" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azuresynapse[*].name) : one(data.azurerm_private_dns_zone.azuresynapse_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azuresynapse[*].id) : one(data.azurerm_private_dns_zone.azuresynapse_secondary[*].id)
  }
}

output "dfs" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.dfs[*].name) : one(data.azurerm_private_dns_zone.dfs_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.dfs[*].id) : one(data.azurerm_private_dns_zone.dfs_secondary[*].id)
  }
}

output "azurehealthcareapis" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azurehealthcareapis[*].name) : one(data.azurerm_private_dns_zone.azurehealthcareapis_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azurehealthcareapis[*].id) : one(data.azurerm_private_dns_zone.azurehealthcareapis_secondary[*].id)
  }
}

output "dicom" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.dicom[*].name) : one(data.azurerm_private_dns_zone.dicom_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.dicom[*].id) : one(data.azurerm_private_dns_zone.dicom_secondary[*].id)
  }
}

output "api" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.api[*].name) : one(data.azurerm_private_dns_zone.api_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.api[*].id) : one(data.azurerm_private_dns_zone.api_secondary[*].id)
  }
}

output "cert" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.cert[*].name) : one(data.azurerm_private_dns_zone.cert_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.cert[*].id) : one(data.azurerm_private_dns_zone.cert_secondary[*].id)
  }
}

output "notebooks" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.notebooks[*].name) : one(data.azurerm_private_dns_zone.notebooks_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.notebooks[*].id) : one(data.azurerm_private_dns_zone.notebooks_secondary[*].id)
  }
}

output "postgres" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.postgres[*].name) : one(data.azurerm_private_dns_zone.postgres_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.postgres[*].id) : one(data.azurerm_private_dns_zone.postgres_secondary[*].id)
  }
}

output "mysql" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.mysql[*].name) : one(data.azurerm_private_dns_zone.mysql_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.mysql[*].id) : one(data.azurerm_private_dns_zone.mysql_secondary[*].id)
  }
}

output "azuredatabricks" {
  value = {
    name = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azuredatabricks[*].name) : one(data.azurerm_private_dns_zone.azuredatabricks_secondary[*].name)
    id   = var.use_primary_dns_zones ? one(data.azurerm_private_dns_zone.azuredatabricks[*].id) : one(data.azurerm_private_dns_zone.azuredatabricks_secondary[*].id)
  }
}
