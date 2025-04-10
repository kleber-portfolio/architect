variable "environment" {
  type        = string
  description = "Ambiente (dev, prod...)"
}

variable "cognito_user_pool_arn" {
  type        = string
}