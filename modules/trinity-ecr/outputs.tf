output "repository_name" {
  description = "Nome do repositório ECR"
  value       = aws_ecr_repository.trinity_repo.name
}

output "repository_url" {
  description = "URL completa do repositório (usada no docker push/pull)"
  value       = aws_ecr_repository.trinity_repo.repository_url
}

output "repository_arn" {
  description = "ARN do repositório ECR"
  value       = aws_ecr_repository.trinity_repo.arn
}

output "registry_id" {
  description = "ID do registro (útil para login e autenticação)"
  value       = aws_ecr_repository.trinity_repo.registry_id
}