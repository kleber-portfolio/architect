variable "rest_api_id" {
  description = "ID do API Gateway REST"
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
  description = "URL da aplicação Morpheus (ex: http://lb-dns)"
  type        = string
}

variable "environment" {
  description = "Ambiente (ex: dev, prod)"
  type        = string
}