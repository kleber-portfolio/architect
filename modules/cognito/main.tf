resource "aws_cognito_user_pool" "this" {
  name = "studio-trek-cognito-${var.environment}"

  alias_attributes    = ["preferred_username", "email"]

  auto_verified_attributes = ["email"]

  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    mutable             = false
  }

  schema {
    name                = "preferred_username"
    attribute_data_type = "String"
    required            = true
    mutable             = true
  }

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_cognito_user_group" "user" {
  user_pool_id = aws_cognito_user_pool.this.id
  name         = "user"
  description  = "Grupo de usuários comuns"
}

resource "aws_cognito_user_group" "management" {
  user_pool_id = aws_cognito_user_pool.this.id
  name         = "management"
  description  = "Grupo de usuários gestores"
}

resource "aws_cognito_user_group" "admin" {
  user_pool_id = aws_cognito_user_pool.this.id
  name         = "admin"
  description  = "Grupo de usuários administradores"
}

resource "aws_cognito_user_pool_client" "this" {
  name         = "studio-trek-app-client-${var.environment}"
  user_pool_id = aws_cognito_user_pool.this.id
  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_USER_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  access_token_validity      = 60
  id_token_validity          = 60
  refresh_token_validity     = 5
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }

  prevent_user_existence_errors = "ENABLED"
  enable_token_revocation       = true

  allowed_oauth_flows_user_pool_client = false
}