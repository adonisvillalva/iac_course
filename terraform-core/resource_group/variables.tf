variable "name" {
    description = "Nombre del grupo de recursos"
    type        = string
}

variable "location" {
    description = "Ubicacion del RG"
    type        = string
}


variable "tags" {
    description = "Etiquetas del RG"
    type        = map(string) 
    default     = {}
}