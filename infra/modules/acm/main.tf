resource "aws_acm_certificate" "main" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  subject_alternative_names = ["*.${var.domain_name}"]

 tags = {
  Name        = "${var.environment}-certificate"
  Environment = var.environment
}

  lifecycle {
    create_before_destroy = true
  }
}