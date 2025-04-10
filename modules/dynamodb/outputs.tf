output "table_name" {
  description = "Nome da tabela DynamoDB"
  value       = aws_dynamodb_table.person.name
}

output "table_arn" {
  description = "ARN da tabela DynamoDB"
  value       = aws_dynamodb_table.person.arn
}