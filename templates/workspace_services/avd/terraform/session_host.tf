module "avd" {
  source              = "./avd"
  location            = data.azurerm_resource_group.ws.location
  resource_group_name = data.azurerm_resource_group.ws.name
  key_vault_id        = data.azurerm_key_vault.ws.id
  name                = local.service_resource_name_suffix
  tags                = local.tre_workspace_service_tags
}

resource "azurerm_network_interface" "session_host_nic" {
  name                = "nic-vm-${var.tre_id}"
  resource_group_name = data.azurerm_resource_group.ws.name
  location            = data.azurerm_resource_group.ws.location
  tags                = local.tre_workspace_service_tags

  ip_configuration {
    name                          = "internalIPConfig"
    subnet_id                     = data.azurerm_subnet.services.id
    private_ip_address_allocation = "Dynamic"
  }

  lifecycle { ignore_changes = [tags] }
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

resource "azurerm_windows_virtual_machine" "session_host" {
  name                       = local.vm_name
  resource_group_name        = data.azurerm_resource_group.ws.name
  location                   = data.azurerm_resource_group.ws.location
  network_interface_ids      = [azurerm_network_interface.session_host_nic.id]
  size                       = local.vm_sizes[var.vm_size]
  allow_extension_operations = true
  admin_username             = "adminuser"
  admin_password             = random_password.password.result
  tags                       = local.tre_workspace_service_tags
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

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_key_vault_secret" "session_host_credentials" {
  name         = "${azurerm_windows_virtual_machine.session_host.name}-session-host-password"
  value        = random_password.password.result
  key_vault_id = data.azurerm_key_vault.ws.id
  tags         = local.tre_workspace_service_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_virtual_machine_extension" "config_script" {
  name                 = "${azurerm_windows_virtual_machine.session_host.name}-vmextension"
  virtual_machine_id   = azurerm_windows_virtual_machine.session_host.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  tags                 = local.tre_workspace_service_tags

  protected_settings = <<PROT
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted -NoProfile -NonInteractive -command \"cp c:/azuredata/customdata.bin c:/azuredata/configure.ps1; c:/azuredata/configure.ps1 \""
    }
  PROT

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  virtual_machine_id         = azurerm_windows_virtual_machine.session_host.id
  name                       = "${azurerm_windows_virtual_machine.session_host.name}-antimalware"
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.7"
  auto_upgrade_minor_version = true
  tags                       = local.tre_workspace_service_tags

  settings = jsonencode({
    "AntimalwareEnabled" = true
  })

  lifecycle { ignore_changes = [tags] }

  depends_on = [azurerm_virtual_machine_extension.config_script]
}

resource "azurerm_virtual_machine_extension" "aad_login" {
  name                 = "${azurerm_windows_virtual_machine.session_host.name}-aad-login"
  virtual_machine_id   = azurerm_windows_virtual_machine.session_host.id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADLoginForWindows"
  type_handler_version = "2.1"

  lifecycle { ignore_changes = [tags] }

  depends_on = [azurerm_virtual_machine_extension.antimalware]
}

resource "azurerm_virtual_machine_extension" "app_dependency" {
  name                       = "${azurerm_windows_virtual_machine.session_host.name}-dependency-agent"
  virtual_machine_id         = azurerm_windows_virtual_machine.session_host.id
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentWindows"
  type_handler_version       = "9.5"
  auto_upgrade_minor_version = true
  tags                       = local.tre_workspace_service_tags

  lifecycle { ignore_changes = [tags] }

  depends_on = [azurerm_virtual_machine_extension.aad_login]
}

resource "azurerm_virtual_machine_extension" "oms_agent" {
  name                       = "${azurerm_windows_virtual_machine.session_host.name}-oms-agent"
  virtual_machine_id         = azurerm_windows_virtual_machine.session_host.id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  tags                       = local.tre_workspace_service_tags

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

resource "azurerm_virtual_machine_extension" "avd-dsc" {
  name                       = "${azurerm_windows_virtual_machine.session_host.name}-avd-dsc"
  virtual_machine_id         = azurerm_windows_virtual_machine.session_host.id
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.73"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
  {
    "modulesUrl": "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_1.0.02566.260.zip",
    "configurationFunction": "Configuration.ps1\\AddSessionHost",
    "properties": {
      "HostPoolName":"${module.avd.hostpool_name}",
      "AadJoin": true,
      "RegistrationInfoTokenCredential": {
        "UserName": "PLACEHOLDER_DO_NOT_USE",
        "Password": "PrivateSettingsRef:RegistrationInfoToken"
      },
      "UseAgentDownloadEndpoint": true
    }
  }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
  {
    "Items": {
      "RegistrationInfoToken": "${module.avd.registration_info_token}"
    }
  }
  PROTECTED_SETTINGS

  lifecycle { ignore_changes = [tags] }

  depends_on = [azurerm_virtual_machine_extension.oms_agent]
}
