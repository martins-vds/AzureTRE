module "avd" {
  source              = "./avd"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  key_vault_id        = data.azurerm_key_vault.keyvault.id
  tre_id              = var.tre_id
}

resource "azurerm_network_interface" "jumpbox_nic" {
  name                = "nic-vm-${var.tre_id}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  tags                = local.tre_shared_service_tags

  ip_configuration {
    name                          = "internalIPConfig"
    subnet_id                     = data.azurerm_subnet.shared.id
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

resource "azurerm_windows_virtual_machine" "jumpbox" {
  name                       = "vm-${var.tre_id}"
  resource_group_name        = data.azurerm_resource_group.rg.name
  location                   = data.azurerm_resource_group.rg.location
  network_interface_ids      = [azurerm_network_interface.jumpbox_nic.id]
  size                       = var.admin_jumpbox_vm_sku
  allow_extension_operations = true
  admin_username             = "adminuser"
  admin_password             = random_password.password.result
  tags                       = local.tre_shared_service_tags
  encryption_at_host_enabled = true

  secure_boot_enabled = true
  vtpm_enabled        = true

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-23h2-avd"
    version   = "latest"
  }

  os_disk {
    name                 = "vm-dsk-${var.tre_id}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_key_vault_secret" "jumpbox_credentials" {
  name         = "${azurerm_windows_virtual_machine.jumpbox.name}-jumpbox-password"
  value        = random_password.password.result
  key_vault_id = data.azurerm_key_vault.keyvault.id
  tags         = local.tre_shared_service_tags

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  virtual_machine_id         = azurerm_windows_virtual_machine.jumpbox.id
  name                       = "${azurerm_windows_virtual_machine.jumpbox.name}-AntimalwareExtension"
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.7"
  auto_upgrade_minor_version = true
  tags                       = local.tre_shared_service_tags

  settings = jsonencode({
    "AntimalwareEnabled" = true
  })

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_virtual_machine_extension" "aad_login" {
  name                 = "${azurerm_windows_virtual_machine.jumpbox.name}-aad-login"
  virtual_machine_id   = azurerm_windows_virtual_machine.jumpbox.id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADLoginForWindows"
  type_handler_version = "2.1"

  lifecycle { ignore_changes = [tags] }
}

resource "azurerm_virtual_machine_extension" "app_dependency" {
  name                       = "${azurerm_windows_virtual_machine.jumpbox.name}-dependency-agent"
  virtual_machine_id         = azurerm_windows_virtual_machine.jumpbox.id
  publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                       = "DependencyAgentWindows"
  type_handler_version       = "9.5"
  auto_upgrade_minor_version = true
  tags                       = local.tre_shared_service_tags

  lifecycle { ignore_changes = [tags] }

  depends_on = [azurerm_virtual_machine_extension.aad_login]
}

resource "azurerm_virtual_machine_extension" "oms_agent" {
  name                       = "${azurerm_windows_virtual_machine.jumpbox.name}-oms-agent"
  virtual_machine_id         = azurerm_windows_virtual_machine.jumpbox.id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "MicrosoftMonitoringAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true
  tags                       = local.tre_shared_service_tags

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
  name                       = "${azurerm_windows_virtual_machine.jumpbox.name}-avd-dsc"
  virtual_machine_id         = azurerm_windows_virtual_machine.jumpbox.id
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
