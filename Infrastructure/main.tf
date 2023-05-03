terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

provider "azapi" {
}



# Create a resource group
resource "azurerm_resource_group" "rg_aut" {
  name     = "control-automation"
  location = "West Europe"
}