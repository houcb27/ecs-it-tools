resource "aws_ecr_repository" "main" {
  name                 = "it-tools"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "it-tools"
    Environment = var.environment
  }
}

