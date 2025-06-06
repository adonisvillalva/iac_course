resource "azurerm_policy_definition" "this" {
  name         = var.policy_name
  policy_type  = "Custom"
  mode         = "All"
  display_name = var.display_name
  description  = var.description
  policy_rule  = file("${path.module}/policy.json")
  parameters   = var.parameters
}

resource "azurerm_subscription_policy_assignment" "this" {
  name                 = "${var.policy_name}-assignment"
  policy_definition_id = azurerm_policy_definition.this.id
  subscription_id      = "/subscriptions/${var.subscription_id}"
  display_name         = var.display_name
  description          = var.description
  parameters           = var.assignment_parameters
}