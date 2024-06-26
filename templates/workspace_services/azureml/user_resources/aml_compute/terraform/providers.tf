terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.86.0"
     }
    azapi = {
      source  = "Azure/azapi"
      version = "=1.12.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {
  }
}

provider "azapi" {}
