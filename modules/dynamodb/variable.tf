variable "environment" {
  description = "Nome do ambiente (ex: dev, prod)"
  type        = string
}

variable "read_capacity" {
  description = "Capacidade de leitura provisionada"
  type        = number
  default     = 5
}

variable "write_capacity" {
  description = "Capacidade de escrita provisionada"
  type        = number
  default     = 5
}