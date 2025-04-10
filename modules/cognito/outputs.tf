output "user_pool_id" {
  description = "ID do User Pool Cognito"
  value       = aws_cognito_user_pool.this.id
}

output "user_pool_arn" {
  description = "ARN do User Pool Cognito"
  value       = aws_cognito_user_pool.this.arn
}

output "user_pool_name" {
  description = "Nome do User Pool Cognito"
  value       = aws_cognito_user_pool.this.name
}

output "group_user" {
  description = "Nome do grupo USER"
  value       = aws_cognito_user_group.user.name
}

output "group_management" {
  description = "Nome do grupo MANAGEMENT"
  value       = aws_cognito_user_group.management.name
}

output "group_admin" {
  description = "Nome do grupo ADMIN"
  value       = aws_cognito_user_group.admin.name
}