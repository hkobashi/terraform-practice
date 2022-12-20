# Public bucket
resource "aws_s3_bucket" "public_bucket" {
  bucket = "hk-terraform-s3-public"
  acl = "public-read"
  force_destroy = true
  cors_rule {
    # allowed access
    allowed_origins = ["*"]
    allowed_methods = ["GET"]
    allowed_headers = ["*"]
    # cache time for browser
    max_age_seconds = 3000
  }
}

# Private bucket
resource "aws_s3_bucket" "private_bucket" {
  bucket = "hk-terraform-s3-private"
  acl = "private"
  force_destroy = true
  tags = {
    Created_by = "Terraform"
  }
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}