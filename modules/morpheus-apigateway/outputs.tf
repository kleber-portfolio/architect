output "method_dependencies" {
  value = [
    aws_api_gateway_method.get_fight,
    aws_api_gateway_integration.get_fight_integration
  ]
}