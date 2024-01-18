provider "azurerm" {
  features {}
}

provider "azurerm" {
  alias           = "secondary"
  client_id       = var.secondary_arm_client_id
  client_secret   = var.secondary_arm_client_secret
  subscription_id = var.secondary_arm_subscription_id
  tenant_id       = var.secondary_arm_tenant_id

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

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = var.mgmt_storage_allowed_subnet_ids
  }

  lifecycle { ignore_changes = [tags] }
}
