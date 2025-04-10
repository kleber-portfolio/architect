variable "rest_api_id" {
  type        = string
  description = "ID da API Gateway REST API"
}

variable "log_group_arn" {
  type        = string
  description = "ARN do CloudWatch Log Group para a API"
}

variable "environment" {
  type        = string
  description = "Ambiente (dev, prod, etc)"
}