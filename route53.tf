data "aws_route53_zone" "discriminator_link" {
  name = "discriminator.link"
}

# dns record for web server
resource "aws_route53_record" "web" {
  zone_id = data.aws_route53_zone.discriminator_link.zone_id
  name = data.aws_route53_zone.discriminator_link.name
  type = "A"
  ttl = "300"
  records = [aws_instance.web.public_ip] # associate ec2's public_ip
}

# internal hosted zone
resource "aws_route53_zone" "internal" {
  name = "internal"
  vpc {
    vpc_id = aws_vpc.vpc.id
    vpc_region = "ap-northeast-1"
  }

  tags = {
    Name = "Internal DNS Zone"
    Created_by = "Terraform"
  }
}

# internal ap's DNS record
resource "aws_route53_record" "ap_internal" {
  zone_id = aws_route53_zone.internal.zone_id
  name = "ap"
  type = "A"
  ttl = "300"
  records = [aws_instance.ap.private_ip]
}

# internal writerDB's DNS record
resource "aws_route53_record" "aurora_clstr_internal" {
  zone_id = aws_route53_zone.internal.zone_id
  name = "rds"
  type = "CNAME"
  ttl = "300"
  records = [aws_rds_cluster.aurora_clstr.endpoint]
}

# internal readDB's DNS record
resource "aws_route53_record" "aurora_clstr_ro_internal" {
  zone_id = aws_route53_zone.internal.zone_id
  name = "rds-ro"
  type = "CNAME"
  ttl = "300"
  records = [aws_rds_cluster.aurora_clstr.reader_endpoint]
}

# acm's settings
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = data.aws_route53_zone.discriminator_link.zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}