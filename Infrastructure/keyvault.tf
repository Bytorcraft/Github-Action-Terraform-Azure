data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "aut_kv" {
  name                = "aut-keyvault"
  location            = azurerm_resource_group.rg_aut.location
  resource_group_name = azurerm_resource_group.rg_aut.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  purge_protection_enabled = true
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = azurerm_key_vault.aut_kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = "13e17103-d412-48b8-89bb-cc78af118ae6"

  key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "GetRotationPolicy"]
  secret_permissions = ["Get", "Set", "List", "Delete"]
}

resource "azurerm_key_vault_access_policy" "terraform" {
  key_vault_id = azurerm_key_vault.aut_kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azuread_service_principal.terraform.object_id

  key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "GetRotationPolicy"]
  secret_permissions = ["Get", "Set", "List", "Delete"]
}

resource "azurerm_key_vault_key" "aut_kvk" {
  name         = "auto-storage-key"
  key_vault_id = azurerm_key_vault.aut_kv.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [
    azurerm_key_vault_access_policy.client,
  ]
}