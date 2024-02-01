data "azurerm_role_definition" "desktop_virtualization_user" { # access an existing built-in role
  name = "Desktop Virtualization User"
}

data "azurerm_role_definition" "virtual_machine_user_login" { # access an existing built-in role
  name = "Virtual Machine User Login"
}
