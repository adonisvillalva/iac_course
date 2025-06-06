variable "policy_name" {
  description = "Nombre de la política de restricción de localización"
  type        = string
  default     = "restrict-resources-to-single-location"
}

variable "display_name" {
  description = "Nombre para mostrar de la política"
  type        = string
  default     = "Restrict resource creation to single location"
}

variable "description" {
  description = "Descripción de la política"
  type        = string
  default     = "Policy to restrict resource creation to a single specified location"
}

variable "subscription_id" {
  description = "ID de la suscripción donde se asignará la política"
  type        = string
}

variable "allowed_location" {
  description = "Localización permitida para la creación de recursos"
  type        = string
  default     = "eastus"
}

variable "excluded_resource_types" {
  description = "Lista de tipos de recursos excluidos de la restricción"
  type        = list(string)
  default     = []
}

variable "parameters" {
  description = "Parámetros para la definición de la política en formato JSON"
  type        = string
  default     = <<EOF
    {
      "allowedLocation": {
        "type": "String",
        "metadata": {
          "displayName": "Allowed location",
          "description": "The only location where resources can be created"
        },
        "defaultValue": "eastus"
      },
      "excludedResourceTypes": {
        "type": "Array",
        "metadata": {
          "displayName": "Excluded resource types",
          "description": "Resource types that are exempt from location restriction"
        },
        "defaultValue": []
      }
    }
  EOF
}

variable "assignment_parameters" {
  description = "Parámetros para la asignación de la política en formato JSON"
  type        = string
  default     = <<EOF
    {
      "allowedLocation": {
        "value": "eastus"
      },
      "excludedResourceTypes": {
        "value": []
      }
    }
  EOF
}