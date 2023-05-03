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
  backend "azurerm" {
    resource_group_name  = "prueba"
    storage_account_name = "strprueba"
    container_name       = "tfstatefile"
    key                  = "terraform.tfstate"
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