variable "name" {
  description = "Nombre del Azure Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group en el que se creará el ACR"
  type        = string
}

variable "location" {
  description = "Ubicación del ACR"
  type        = string
}

variable "sku" {
  description = "SKU del ACR (Basic, Standard, Premium)"
  type        = string
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Habilitar acceso administrador (no recomendado en producción)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Etiquetas"
  type        = map(string)
  default     = {}
}

variable "principal_id" {
  description = "Principal ID de la identidad que necesita acceso (por ejemplo, SWA MSI)"
  type        = string
  default     = null
}
