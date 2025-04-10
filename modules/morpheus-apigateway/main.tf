resource "aws_api_gateway_resource" "morpheus" {
  rest_api_id = var.rest_api_id
  parent_id   = var.resource_parent_id
  path_part   = "morpheus"
}

resource "aws_api_gateway_resource" "v1" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.morpheus.id
  path_part   = "v1"
}

resource "aws_api_gateway_resource" "fight" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "health"
}

resource "aws_api_gateway_method" "get_fight" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.fight.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = var.authorizer_id
}

resource "aws_api_gateway_integration" "get_fight_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.fight.id
  http_method             = aws_api_gateway_method.get_fight.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "${var.integration_url}/morpheus/v1/fight"
}