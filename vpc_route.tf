### パブリックサブネット用ルートテーブル ###
resource "aws_route_table" "public_a" {
  vpc_id = aws_vpc.vpc.id
  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "rtb-pub-a"
    Created_by = "Terraform"
  }
}
# 上記で作成したルートテーブルをパブリックサブネットに関連付け
resource "aws_route_table_association" "pubilc_a" {
  subnet_id = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_a.id
}

### プライベートサブネット用ルートテーブル ###
# resource "aws_route_table" "private_a" {
#   vpc_id = aws_vpc.vpc.id
#   route {
#     nat_gateway_id = aws_nat_gateway.ngw_pub_a.id
#     cidr_block = "0.0.0.0/0"
#   }
#   tags = {
#     Name = "rtb-priv-a"
#     Created_by = "Terraform"
#   }
# }
# # 上記で作成したルートテーブルをプライベートサブネットに関連付け
# resource "aws_route_table_association" "priveate_a" {
#   subnet_id = aws_subnet.private_a.id
#   route_table_id = aws_route_table.private_a.id
# }