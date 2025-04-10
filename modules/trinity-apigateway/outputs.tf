output "method_dependencies" {
  value = [
    aws_api_gateway_method.post_person,
    aws_api_gateway_integration.post_person_integration,
    aws_api_gateway_method.get_person,
    aws_api_gateway_integration.get_person_integration
  ]
}