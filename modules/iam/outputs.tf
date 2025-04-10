output "role_name" {
  description = "Nome da IAM Role criada"
  value       = aws_iam_role.lambda_role.name
}

output "role_arn" {
  description = "ARN da IAM Role criada"
  value       = aws_iam_role.lambda_role.arn
}

output "role_id" {
  description = "ID da IAM Role criada"
  value       = aws_iam_role.lambda_role.id
}