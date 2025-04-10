output "rest_api_id" {
  value = aws_api_gateway_rest_api.this.id
}

output "root_resource_id" {
  value = aws_api_gateway_rest_api.this.root_resource_id
}

output "authorizer_id" {
  value = aws_api_gateway_authorizer.cognito.id
}

output "log_group_arn" {
  description = "ARN do grupo de logs do API Gateway"
  value       = aws_cloudwatch_log_group.api_gw_logs.arn
}