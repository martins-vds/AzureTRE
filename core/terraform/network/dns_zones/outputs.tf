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
