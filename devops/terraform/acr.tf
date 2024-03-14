# Shared container registry
resource "azurerm_container_registry" "shared_acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.mgmt.name
  location            = azurerm_resource_group.mgmt.location
  sku                 = var.acr_sku
  admin_enabled       = true

  network_rule_bypass_option = "AzureServices"

  lifecycle { ignore_changes = [tags] }
}


# tredev is the devcontainer image name generate by our CICD
resource "azurerm_container_registry_task" "tredev_purge" {
  name                  = "tredev_purge"
  container_registry_id = azurerm_container_registry.shared_acr.id
  platform {
    os           = "Linux"
    architecture = "amd64"
  }
  encoded_step {
    task_content = <<EOF
version: v1.1.0
steps:
  - cmd: acr purge   --filter 'tredev:[0-9a-fA-F]{8}'   --ago 7d --untagged
    disableWorkingDirectoryOverride: true
    timeout: 600
EOF
  }

  timer_trigger {
    name     = "t1"
    schedule = "4 1 * * *"
    enabled  = true
  }

  lifecycle { ignore_changes = [tags] }
}
