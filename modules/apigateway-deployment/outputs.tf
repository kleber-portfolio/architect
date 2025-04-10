output "stage_name" {
  value       = aws_api_gateway_stage.this.stage_name
  description = "Nome do stage criado para a API"
}