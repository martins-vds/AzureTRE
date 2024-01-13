resource "azurerm_storage_account_network_rules" "network_rules" {
  storage_account_id = data.azurerm_storage_account.mgmt_stg.id

  default_action = "Deny"
  virtual_network_subnet_ids = [ azurerm_subnet.resource_processor.id ]
}
