output "cluster_name" {
  description = "Nome do ECS Cluster"
  value       = aws_ecs_cluster.this.name
}

output "cluster_id" {
  description = "ID do ECS Cluster (para uso em serviços)"
  value       = aws_ecs_cluster.this.id
}