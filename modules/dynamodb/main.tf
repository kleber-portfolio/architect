resource "aws_dynamodb_table" "person" {
  name         = "person-${var.environment}"
  billing_mode = "PROVISIONED"

  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Environment = var.environment
    Name        = "person-${var.environment}"
  }
}