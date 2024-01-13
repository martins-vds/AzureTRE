resource "azurerm_storage_account" "state_storage" {
  name                            = var.mgmt_storage_account_name
  resource_group_name             = azurerm_resource_group.mgmt.name
  location                        = azurerm_resource_group.mgmt.location
  account_tier                    = "Standard"
  account_kind                    = "StorageV2"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false

  network_rules {
    default_action = "Deny"
    virtual_network_subnet_ids = [ module.network.resource_processor_subnet_id ]
  }

  lifecycle { ignore_changes = [tags] }
}
