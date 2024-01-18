output "azure_monitor" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.azure_monitor[*].name) : one(data.azurerm_private_dns_zone.azure_monitor[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.azure_monitor[*].id) : one(data.azurerm_private_dns_zone.azure_monitor[*].id)
  }
}

output "azure_monitor_oms_opinsights" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.azure_monitor_oms_opinsights[*].name) : one(data.azurerm_private_dns_zone.azure_monitor_oms_opinsights[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.azure_monitor_oms_opinsights[*].id) : one(data.azurerm_private_dns_zone.azure_monitor_oms_opinsights[*].id)
  }
}

output "azure_monitor_ods_opinsights" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.azure_monitor_ods_opinsights[*].name) : one(data.azurerm_private_dns_zone.azure_monitor_ods_opinsights[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.azure_monitor_ods_opinsights[*].id) : one(data.azurerm_private_dns_zone.azure_monitor_ods_opinsights[*].id)
  }
}

output "azure_monitor_agentsvc" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.azure_monitor_agentsvc[*].name) : one(data.azurerm_private_dns_zone.azure_monitor_agentsvc[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.azure_monitor_agentsvc[*].id) : one(data.azurerm_private_dns_zone.azure_monitor_agentsvc[*].id)
  }
}

output "blobcore" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.blobcore[*].name) : one(data.azurerm_private_dns_zone.blobcore[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.blobcore[*].id) : one(data.azurerm_private_dns_zone.blobcore[*].id)
  }
}

output "azurewebsites" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.azurewebsites[*].name) : one(data.azurerm_private_dns_zone.azurewebsites[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.azurewebsites[*].id) : one(data.azurerm_private_dns_zone.azurewebsites[*].id)
  }
}

output "static_web" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.static_web[*].name) : one(data.azurerm_private_dns_zone.static_web[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.static_web[*].id) : one(data.azurerm_private_dns_zone.static_web[*].id)
  }
}

output "filecore" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.filecore[*].name) : one(data.azurerm_private_dns_zone.filecore[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.filecore[*].id) : one(data.azurerm_private_dns_zone.filecore[*].id)
  }
}

output "vaultcore" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.vaultcore[*].name) : one(data.azurerm_private_dns_zone.vaultcore[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.vaultcore[*].id) : one(data.azurerm_private_dns_zone.vaultcore[*].id)
  }
}

output "azurecr" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.azurecr[*].name) : one(data.azurerm_private_dns_zone.azurecr[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.azurecr[*].id) : one(data.azurerm_private_dns_zone.azurecr[*].id)
  }
}

output "eventgrid" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.eventgrid[*].name) : one(data.azurerm_private_dns_zone.eventgrid[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.eventgrid[*].id) : one(data.azurerm_private_dns_zone.eventgrid[*].id)
  }
}

output "table" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.table[*].name) : one(data.azurerm_private_dns_zone.table[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.table[*].id) : one(data.azurerm_private_dns_zone.table[*].id)
  }
}

output "queue" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.queue[*].name) : one(data.azurerm_private_dns_zone.queue[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.queue[*].id) : one(data.azurerm_private_dns_zone.queue[*].id)
  }
}

output "servicebus" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.servicebus[*].name) : one(data.azurerm_private_dns_zone.servicebus[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.servicebus[*].id) : one(data.azurerm_private_dns_zone.servicebus[*].id)
  }
}

output "cosmos" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.cosmos[*].name) : one(data.azurerm_private_dns_zone.cosmos[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.cosmos[*].id) : one(data.azurerm_private_dns_zone.cosmos[*].id)
  }
}

output "mongo" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.mongo[*].name) : one(data.azurerm_private_dns_zone.mongo[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.mongo[*].id) : one(data.azurerm_private_dns_zone.mongo[*].id)
  }
}

output "purview" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.purview[*].name) : one(data.azurerm_private_dns_zone.purview[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.purview[*].id) : one(data.azurerm_private_dns_zone.purview[*].id)
  }
}

output "purviewstudio" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.purviewstudio[*].name) : one(data.azurerm_private_dns_zone.purviewstudio[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.purviewstudio[*].id) : one(data.azurerm_private_dns_zone.purviewstudio[*].id)
  }
}

output "sql" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.sql[*].name) : one(data.azurerm_private_dns_zone.sql[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.sql[*].id) : one(data.azurerm_private_dns_zone.sql[*].id)
  }
}

output "dev" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.dev[*].name) : one(data.azurerm_private_dns_zone.dev[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.dev[*].id) : one(data.azurerm_private_dns_zone.dev[*].id)
  }
}

output "azuresynapse" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.azuresynapse[*].name) : one(data.azurerm_private_dns_zone.azuresynapse[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.azuresynapse[*].id) : one(data.azurerm_private_dns_zone.azuresynapse[*].id)
  }
}

output "dfs" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.dfs[*].name) : one(data.azurerm_private_dns_zone.dfs[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.dfs[*].id) : one(data.azurerm_private_dns_zone.dfs[*].id)
  }
}

output "azurehealthcareapis" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.azurehealthcareapis[*].name) : one(data.azurerm_private_dns_zone.azurehealthcareapis[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.azurehealthcareapis[*].id) : one(data.azurerm_private_dns_zone.azurehealthcareapis[*].id)
  }
}

output "dicom" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.dicom[*].name) : one(data.azurerm_private_dns_zone.dicom[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.dicom[*].id) : one(data.azurerm_private_dns_zone.dicom[*].id)
  }
}

output "api" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.api[*].name) : one(data.azurerm_private_dns_zone.api[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.api[*].id) : one(data.azurerm_private_dns_zone.api[*].id)
  }
}

output "cert" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.cert[*].name) : one(data.azurerm_private_dns_zone.cert[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.cert[*].id) : one(data.azurerm_private_dns_zone.cert[*].id)
  }
}

output "notebooks" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.notebooks[*].name) : one(data.azurerm_private_dns_zone.notebooks[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.notebooks[*].id) : one(data.azurerm_private_dns_zone.notebooks[*].id)
  }
}

output "postgres" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.postgres[*].name) : one(data.azurerm_private_dns_zone.postgres[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.postgres[*].id) : one(data.azurerm_private_dns_zone.postgres[*].id)
  }
}

output "mysql" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.mysql[*].name) : one(data.azurerm_private_dns_zone.mysql[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.mysql[*].id) : one(data.azurerm_private_dns_zone.mysql[*].id)
  }
}

output "azuredatabricks" {
  value = {
    name = var.create_dns_zones ? one(azurerm_private_dns_zone.azuredatabricks[*].name) : one(data.azurerm_private_dns_zone.azuredatabricks[*].name)
    id   = var.create_dns_zones ? one(azurerm_private_dns_zone.azuredatabricks[*].id) : one(data.azurerm_private_dns_zone.azuredatabricks[*].id)
  }
}
