# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.87.0"
     }
    local = {
      source  = "hashicorp/local"
      version = "=2.4.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}
