provider "azurerm" {
  features {}
}

# Resource group for TRE core management
resource "azurerm_resource_group" "mgmt" {
  name     = var.mgmt_resource_group_name
  location = var.location

  tags = {
    project = "Azure Trusted Research Environment"
    source  = "https://github.com/microsoft/AzureTRE/"
  }

  lifecycle { ignore_changes = [tags] }
}

# Holds Terraform shared state (already exists, created by bootstrap.sh)
resource "azurerm_storage_account" "state_storage" {
  name                            = var.mgmt_storage_account_name
  resource_group_name             = azurerm_resource_group.mgmt.name
  location                        = azurerm_resource_group.mgmt.location
  account_tier                    = "Standard"
  account_kind                    = "StorageV2"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false

  lifecycle { ignore_changes = [tags] }
}
