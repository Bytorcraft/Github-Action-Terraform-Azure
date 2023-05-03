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
    resource_group_name  = "control-automation"
    storage_account_name = "autstorageaccount"
    container_name       = "aut-tfstate"
    key                  = "terraform.tfstate"
    depends_on = [
      azurerm_storage_container.sc_aut_tfstate
    ]
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