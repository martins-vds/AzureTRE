resource "azurerm_cosmosdb_account" "tre_db_account" {
  name                          = "cosmos-${var.tre_id}"
  location                      = azurerm_resource_group.core.location
  resource_group_name           = azurerm_resource_group.core.name
  offer_type                    = "Standard"
  kind                          = "GlobalDocumentDB"
  enable_automatic_failover     = false
  ip_range_filter               = "${local.azure_portal_cosmos_ips}${var.enable_local_debugging ? ",${local.myip}" : ""}"
  tags                          = local.tre_core_tags
  public_network_access_enabled = false

  dynamic "capabilities" {
    # We can't change an existing cosmos
    for_each = var.is_cosmos_defined_throughput ? [] : [1]
    content {
      name = "EnableServerless"
    }
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = azurerm_resource_group.core.location
    failover_priority = 0
  }

  lifecycle { ignore_changes = [tags] }
}

moved {
  from = azurerm_cosmosdb_account.tre-db-account
  to   = azurerm_cosmosdb_account.tre_db_account
}

resource "azurerm_cosmosdb_sql_database" "tre_db" {
  name                = "AzureTRE"
  resource_group_name = azurerm_resource_group.core.name
  account_name        = azurerm_cosmosdb_account.tre_db_account.name
}

moved {
  from = azurerm_cosmosdb_sql_database.tre-db
  to   = azurerm_cosmosdb_sql_database.tre_db
}

resource "azurerm_management_lock" "tre_db" {
  count      = var.stateful_resources_locked ? 1 : 0
  name       = "tre-db-lock"
  scope      = azurerm_cosmosdb_sql_database.tre_db.id
  lock_level = "CanNotDelete"
  notes      = "Locked to prevent accidental deletion"
}

moved {
  from = azurerm_management_lock.tre-db
  to   = azurerm_management_lock.tre_db
}

resource "azurerm_private_endpoint" "sspe" {
  name                = "pe-ss-${var.tre_id}"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
  subnet_id           = module.network.shared_subnet_id
  tags                = local.tre_core_tags
  lifecycle { ignore_changes = [tags] }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [module.network.cosmos_core_dns_zone_id]
  }

  private_service_connection {
    name                           = "psc-ss-${var.tre_id}"
    private_connection_resource_id = azurerm_cosmosdb_account.tre_db_account.id
    is_manual_connection           = false
    subresource_names              = ["Sql"]
  }
}
