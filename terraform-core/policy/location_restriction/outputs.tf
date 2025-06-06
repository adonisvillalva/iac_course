output "policy_definition_id" {
  description = "ID de la definición de política creada"
  value       = azurerm_policy_definition.this.id
}

output "policy_assignment_id" {
  description = "ID de la asignación de política creada"
  value       = azurerm_subscription_policy_assignment.this.id
}