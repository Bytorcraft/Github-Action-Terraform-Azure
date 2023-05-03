resource "azurerm_storage_account" "sa_aut" {
  name                     = "minaya_storageaccount"
  resource_group_name      = azurerm_resource_group.rg_aut.name
  location                 = azurerm_resource_group.rg_aut.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_container" "sc_aut_reports" {
  name                  = "aut-storagecontainer-reports"
  storage_account_name  = azurerm_storage_account.sa_aut.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "sc_aut_input" {
  name                  = "aut-storagecontainer-inputs"
  storage_account_name  = azurerm_storage_account.sa_aut.name
  container_access_type = "private"
}