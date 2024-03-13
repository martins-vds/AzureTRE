terraform {
  # In modules we should only specify the min version
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.86.0"

      configuration_aliases = [ azurerm.primary, azurerm.secondary ]
     }
  }
}
