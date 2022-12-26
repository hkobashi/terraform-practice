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

resource "aws_s3_bucket" "alb_access_log" {
  bucket = "hk-terraform-s3-access-log"
  acl = "private"
  force_destroy = true
  tags = {
    Name = "hk-terraform-s3-access-log"
    Created_by = "Terraform"
  }
  lifecycle_rule {
    enabled = true
    id = "alb-access-log-web"
    expiration {
      days = 1
    }
  }
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::582318560864:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::hk-terraform-s3-access-log/*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::hk-terraform-s3-access-log/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::hk-terraform-s3-access-log"
    }
  ]
}
POLICY

}