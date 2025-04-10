variable "rest_api_id" {
  description = "ID do API Gateway"
  type        = string
}

variable "resource_parent_id" {
  description = "ID do recurso raiz do API Gateway"
  type        = string
}

variable "authorizer_id" {
  description = "ID do autorizador Cognito"
  type        = string
}

variable "integration_url" {
  description = "URL de integração do backend da aplicação Trinity"
  type        = string
}

variable "environment" {
  description = "Ambiente de deploy (ex: dev, prod)"
  type        = string
}