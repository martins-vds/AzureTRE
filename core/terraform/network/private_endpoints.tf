resource "azurerm_private_endpoint" "mgmtblobpe" {
  name                = "pe-mgmt-blob-${var.tre_id}"
  location            = data.azurerm_storage_account.mgmt_stg.location
  resource_group_name = data.azurerm_storage_account.mgmt_stg.resource_group_name
  subnet_id           = azurerm_subnet.shared.id
  tags                = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }

  private_dns_zone_group {
    name                 = "private-dns-zone-group-blobmgmt"
    private_dns_zone_ids = [azurerm_private_dns_zone.blobcore.id]
  }

  private_service_connection {
    name                           = "psc-stg-mgmt-${var.tre_id}"
    private_connection_resource_id = data.azurerm_storage_account.mgmt_stg.id
    is_manual_connection           = false
    subresource_names              = ["Blob"]
  }
}

resource "azurerm_private_endpoint" "mgmt_acr_pe" {
  name                = "pe-mgmt-acr-${var.tre_id}"
  location            = data.azurerm_container_registry.mgmt_acr.location
  resource_group_name = data.azurerm_container_registry.mgmt_acr.resource_group_name
  subnet_id           = azurerm_subnet.shared.id
  tags                = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }

  private_dns_zone_group {
    name                 = "private-dns-zone-group-mgmtacr"
    private_dns_zone_ids = [azurerm_private_dns_zone.azurecr.id]
  }

  private_service_connection {
    name                           = "psc-acr-mgmt-${var.tre_id}"
    private_connection_resource_id = data.azurerm_container_registry.mgmt_acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }

  depends_on = [
    azurerm_virtual_network.core,
    azurerm_subnet.shared
  ]
}
