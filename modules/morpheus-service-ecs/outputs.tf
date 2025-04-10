output "service_name" {
  description = "Nome do ECS Service"
  value       = aws_ecs_service.this.name
}

output "security_group_id" {
  value = aws_security_group.task.id
}

output "task_definition_arn" {
  description = "ARN da task definition criada"
  value       = aws_ecs_task_definition.this.arn
}