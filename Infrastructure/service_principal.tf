resource "azuread_application" "terraform" {
  display_name = "terraform"
  owners       = "13e17103-d412-48b8-89bb-cc78af118ae6"
}

resource "azuread_service_principal" "terraform" {
  application_id               = azuread_application.terraform.application_id
  app_role_assignment_required = false
  owners                       = "13e17103-d412-48b8-89bb-cc78af118ae6"
}

resource "azuread_service_principal_password" "terraform" {
  service_principal_id = azuread_service_principal.terraform.object_id
}

resource "azurerm_role_assignment" "ra_subscription_terraform" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.terraform.id
}