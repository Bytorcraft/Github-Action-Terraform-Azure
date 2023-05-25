data "azurerm_client_config" "curret" {}

resource "azurerm_key_vault" "aut_kv" {
  name                = "aut-storage-keyvault"
  location            = azurerm_resource_group.rg_aut.location
  resource_group_name = azurerm_resource_group.rg_aut.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  purge_protection_enabled = true
}

resource "azurerm_key_vault_key" "aut_kvk" {
  name         = "auto-storage-key"
  key_vault_id = azurerm_key_vault.aut_kv.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
}