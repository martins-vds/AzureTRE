# See https://microsoft.github.io/AzureTRE/tre-developers/letsencrypt/
resource "azurerm_storage_account" "staticweb" {
  name                            = local.staticweb_storage_name
  resource_group_name             = azurerm_resource_group.core.name
  location                        = var.location
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  enable_https_traffic_only       = true
  allow_nested_items_to_be_public = false
  tags                            = local.tre_core_tags

  static_website {
    index_document     = "index.html"
    error_404_document = "index.html"
  }

  lifecycle { ignore_changes = [tags] }

  network_rules {
    bypass         = ["AzureServices"]
    default_action = "Deny"
    virtual_network_subnet_ids = var.core_static_web_allowed_subnet_ids
  }
}

# Assign the "Storage Blob Data Contributor" role needed for uploading certificates to the storage account
resource "azurerm_role_assignment" "stgwriter" {
  scope                = azurerm_storage_account.staticweb.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_private_endpoint" "webpe" {
  name                = "pe-web-${local.staticweb_storage_name}"
  location            = var.location
  resource_group_name = azurerm_resource_group.core.name
  subnet_id           = module.network.shared_subnet_id
  tags                = local.tre_core_tags

  lifecycle { ignore_changes = [tags] }

  private_dns_zone_group {
    name                 = "private-dns-zone-group-web"
    private_dns_zone_ids = [module.network.static_web_dns_zone_id]
  }

  private_service_connection {
    name                           = "psc-web-${local.staticweb_storage_name}"
    private_connection_resource_id = azurerm_storage_account.staticweb.id
    is_manual_connection           = false
    subresource_names              = ["web"]
  }
}
