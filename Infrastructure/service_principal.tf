resource "azuread_application" "terraform" {
  display_name = "terraform"
}

resource "azuread_service_principal" "terraform" {
  application_id               = azuread_application.terraform.application_id
  app_role_assignment_required = false
}

resource "azuread_service_principal_password" "terraform" {
  service_principal_id = azuread_service_principal.terraform.object_id
}

resource "azurerm_role_assignment" "ra_subscription_terraform" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.terraform.id
}