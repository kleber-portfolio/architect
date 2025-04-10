resource "null_resource" "wait_for_methods" {
  triggers = {
    always_run = timestamp()
  }
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = var.rest_api_id

  triggers = {
    redeploy = timestamp()
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [null_resource.wait_for_methods]
}

resource "aws_api_gateway_stage" "this" {
  stage_name    = var.environment
  rest_api_id   = var.rest_api_id
  deployment_id = aws_api_gateway_deployment.this.id

  access_log_settings {
    destination_arn = var.log_group_arn
    format = jsonencode({
      requestId = "$context.requestId"
      status    = "$context.status"
      error     = "$context.error.message"
    })
  }

  tags = {
    Environment = var.environment
  }
}
