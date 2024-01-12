terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.87.0"
     }
    azapi = {
      source  = "Azure/azapi"
      version = "=1.1.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {
  }
}

provider "azapi" {}
