# インターネットゲートウェイ
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw"
  }
}

# NATゲートウェイ
# resource "aws_nat_gateway" "ngw_pub_a" {
#   allocation_id = aws_eip.ngw_pub_a.id
#   subnet_id = aws_subnet.public_a.id
#   tags = {
#     Name = "ngw-pub-a"
#     Created_by = "Terraform"
#   }
# }