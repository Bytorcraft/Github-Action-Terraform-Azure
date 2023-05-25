data "azurerm_subscription" "primary" {}

resource "azurerm_user_assigned_identity" "aut_ai" {
  location            = azurerm_resource_group.rg_aut.location
  name                = "aut-managed-identity"
  resource_group_name = azurerm_resource_group.rg_aut.name
}

resource "azurerm_role_assignment" "ra_subscription" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.aut_ai.principal_id
}

resource "azurerm_role_assignment" "ra_storage" {
  scope                = azurerm_storage_account.sa_aut.id
  role_definition_name = "Owner"
  principal_id         = azurerm_user_assigned_identity.aut_ai.principal_id
}

resource "azurerm_role_assignment" "ra_keyvault" {
  scope                = azurerm_key_vault.aut_kv.id
  role_definition_name = "Key Vault Reader"
  principal_id         = azurerm_user_assigned_identity.aut_ai.principal_id
}

resource "azurerm_role_assignment" "ra_storage_keyvault" {
  scope                = azurerm_storage_account.sa_aut.id
  role_definition_name = "Storage Account Key Operator Service Role"
  principal_id         = azurerm_user_assigned_identity.aut_ai.principal_id
}