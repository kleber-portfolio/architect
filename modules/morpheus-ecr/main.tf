resource "aws_ecr_repository" "morpheus_repo" {
  name                 = "morpheus-repo-${var.environment}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Environment = var.environment
    Name        = "morpheus_repo-${var.environment}"
  }
}

resource "null_resource" "push_dummy_image" {
  provisioner "local-exec" {
    command = <<EOT
      aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com
      docker pull public.ecr.aws/amazonlinux/amazonlinux:latest
      docker tag public.ecr.aws/amazonlinux/amazonlinux:latest ${aws_ecr_repository.morpheus_repo.repository_url}:0.0.1-SNAPSHOT
      docker push ${aws_ecr_repository.morpheus_repo.repository_url}:0.0.1-SNAPSHOT
    EOT
  }
  depends_on = [aws_ecr_repository.morpheus_repo]
}

data "aws_caller_identity" "current" {}