resource "azurerm_network_interface" "internal" {
  name                = "internal-nic-${local.service_resource_name_suffix}"
  location            = data.azurerm_resource_group.ws.location
  resource_group_name = data.azurerm_resource_group.ws.name
  tags                = local.tre_user_resources_tags

  ip_configuration {
    name                          = "primary"
    subnet_id                     = data.azurerm_subnet.services.id
    private_ip_address_allocation = "Dynamic"
  }

  lifecycle { ignore_changes = [tags] }
}

resource "random_string" "username" {
  length      = 4
  upper       = true
  lower       = true
  numeric     = true
  min_numeric = 1
  min_lower   = 1
  special     = false
}

resource "random_password" "password" {
  length           = 16
  lower            = true
  min_lower        = 1
  upper            = true
  min_upper        = 1
  numeric          = true
  min_numeric      = 1
  special          = true
  min_special      = 1
  override_special = "_%@"
}

resource "azurerm_windows_virtual_machine" "windowsvm" {
  name                       = local.vm_name
  location                   = data.azurerm_resource_group.ws.location
  resource_group_name        = data.azurerm_resource_group.ws.name
  network_interface_ids      = [azurerm_network_interface.internal.id]
  size                       = local.vm_sizes[var.vm_size]
  allow_extension_operations = true
  admin_username             = random_string.username.result
  admin_password             = random_password.password.result
  encryption_at_host_enabled = true

  custom_data = base64encode(templatefile(
    "${path.module}/vm_config.ps1", {
      nexus_proxy_url        = local.nexus_proxy_url
      SharedStorageAccess    = var.shared_storage_access ? 1 : 0
      StorageAccountName     = data.azurerm_storage_account.stg.name
      StorageAccountKey      = data.azurerm_storage_account.stg.primary_access_key
      StorageAccountFileHost = data.azurerm_storage_account.stg.primary_file_host
      FileShareName          = var.shared_storage_access ? data.azurerm_storage_share.shared_storage[0].name : ""
      CondaConfig            = local.selected_image.conda_config ? 1 : 0
    }
  ))

  # set source_image_id/reference depending on the config for the selected image
  source_image_id = local.selected_image_source_id
  dynamic "source_image_reference" {
    for_each = local.selected_image_source_refs
    content {
      publisher = source_image_reference.value["publisher"]
      offer     = source_image_reference.value["offer"]
      sku       = source_image_reference.value["sku"]
      version   = source_image_reference.value["version"]
    }
  }

  os_disk {
    name                 = "osdisk-${local.vm_name}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.tre_user_resources_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_virtual_machine_extension" "config_script" {
  name                 = "${azurerm_windows_virtual_machine.windowsvm.name}-vmextension"
  virtual_machine_id   = azurerm_windows_virtual_machine.windowsvm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  tags                 = local.tre_user_resources_tags

  protected_settings = <<PROT
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted -NoProfile -NonInteractive -command \"cp c:/azuredata/customdata.bin c:/azuredata/configure.ps1; c:/azuredata/configure.ps1 \""
    }
  PROT

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  virtual_machine_id         = azurerm_windows_virtual_machine.windowsvm.id
  name                       = "${azurerm_windows_virtual_machine.windowsvm.name}-antimalware"
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.7"
  auto_upgrade_minor_version = true
  tags                       = local.tre_user_resources_tags

  settings = jsonencode({
    "AntimalwareEnabled" = true
  })

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_virtual_machine_extension" "aad_login" {
  name                 = "${azurerm_windows_virtual_machine.windowsvm.name}-aad-login"
  virtual_machine_id   = azurerm_windows_virtual_machine.windowsvm.id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADLoginForWindows"
  type_handler_version = "2.1"
  tags                 = local.tre_user_resources_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_virtual_machine_extension" "app_dependency" {
  name                       = "${azurerm_windows_virtual_machine.windowsvm.name}-dependency-agent"
  virtual_machine_id         = azurerm_windows_virtual_machine.windowsvm.id
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentWindows"
  type_handler_version       = "9.5"
  auto_upgrade_minor_version = true
  tags                       = local.tre_user_resources_tags

  lifecycle { ignore_changes = [tags] }

  depends_on = [azurerm_virtual_machine_extension.aad_login]
}

resource "azurerm_virtual_machine_extension" "oms_agent" {
  name                       = "${azurerm_windows_virtual_machine.windowsvm.name}-oms-agent"
  virtual_machine_id         = azurerm_windows_virtual_machine.windowsvm.id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  tags                       = local.tre_user_resources_tags

  settings = <<SETTINGS
  {
    "workspaceId": "${data.azurerm_log_analytics_workspace.oms-workspace.workspace_id}",
    "stopOnMultipleConnections": true
  }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
  {
      "workspaceKey": "${data.azurerm_log_analytics_workspace.oms-workspace.primary_shared_key}"
  }
  PROTECTED_SETTINGS

  lifecycle { ignore_changes = [tags] }

  depends_on = [azurerm_virtual_machine_extension.app_dependency]
}

resource "azurerm_role_assignment" "vm_user_role_assignment" {
  scope                = azurerm_windows_virtual_machine.windowsvm.id
  role_definition_name = "Virtual Machine User Login"
  principal_id         = var.vm_users_object_id
}

resource "azurerm_key_vault_secret" "windowsvm_password" {
  name         = "${local.vm_name}-admin-credentials"
  value        = "${random_string.username.result}\n${random_password.password.result}"
  key_vault_id = data.azurerm_key_vault.ws.id
  tags         = local.tre_user_resources_tags

  lifecycle { ignore_changes = [tags] }
}
