data "azurerm_role_definition" "desktop_virtualization_user" { # access an existing built-in role
  provider = azurerm.avdsubscription
  name     = "Desktop Virtualization User"
}

data "azurerm_role_definition" "virtual_machine_user_login" { # access an existing built-in role
  provider = azurerm.avdsubscription
  name     = "Virtual Machine User Login"
}
