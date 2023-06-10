# settings for certification
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate
resource "aws_acm_certificate" "cert" {
  domain_name = "discriminator.link"
  validation_method = "DNS"
  tags = {
    Name = "ssl-certification"
    Created_by = "Terraform"
  }
}