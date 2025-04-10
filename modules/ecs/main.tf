resource "aws_ecs_cluster" "this" {
  name = "studio-trek-cluster-${var.environment}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name        = "studio-trek-cluster"
    Environment = var.environment
  }
}