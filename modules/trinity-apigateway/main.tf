resource "aws_api_gateway_resource" "trinity" {
  rest_api_id = var.rest_api_id
  parent_id   = var.resource_parent_id
  path_part   = "trinity"
}

resource "aws_api_gateway_resource" "v1" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.trinity.id
  path_part   = "v1"
}

resource "aws_api_gateway_resource" "person" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "person"
}

resource "aws_api_gateway_method" "post_person" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.person.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = var.authorizer_id
}

resource "aws_api_gateway_integration" "post_person_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.person.id
  http_method             = aws_api_gateway_method.post_person.http_method
  integration_http_method = "POST"
  type                    = "HTTP_PROXY"
  uri                     = "${var.integration_url}/trinity/v1/person"
}

resource "aws_api_gateway_resource" "person_id" {
  rest_api_id = var.rest_api_id
  parent_id   = aws_api_gateway_resource.person.id
  path_part   = "{id}"
}

resource "aws_api_gateway_method" "get_person" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.person_id.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = var.authorizer_id
  request_parameters = {
    "method.request.path.id" = true
  }
}

resource "aws_api_gateway_integration" "get_person_integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.person_id.id
  http_method             = aws_api_gateway_method.get_person.http_method
  integration_http_method = "GET"
  type                    = "HTTP_PROXY"
  uri                     = "${var.integration_url}/trinity/v1/person/{id}"
  request_parameters = {
    "integration.request.path.id" = "method.request.path.id"
  }
}