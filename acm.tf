# settings for certification
resource "aws_acm_certificate" "cert" {
  domain_name = "discriminator.link"
  validation_method = "DNS"
  tags = {
    Name = "ssl-certification"
    Created_by = "Terraform"
  }
}