resource "azurerm_container_registry" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled

  tags = var.tags
}

resource "azurerm_role_assignment" "swa_acr_reader" {
  for_each = var.principal_id != null ? { "assign" = true } : {}

  scope                = azurerm_container_registry.this.id
  role_definition_name = "AcrPull"
  principal_id         = var.principal_id
}