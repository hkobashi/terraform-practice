resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  # DNSサポートを有効化
  enable_dns_support = "true"
  # DNSホスト名を有効化
  enable_dns_hostnames = "true"
  tags = {
    Name = "dev-vpc"
    Created_by = "Terraform"
  }
}