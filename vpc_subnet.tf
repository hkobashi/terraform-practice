### PublicSubnet
resource "aws_subnet" "public_a" {
  vpc_id = aws_vpc.vpc.id # vpc.tfで作成したVPCに所属することを宣言
  cidr_block = "10.0.1.0/24"
  # AZを指定
  availability_zone = "ap-northeast-1a"
  # 当サブネットで起動したインスタンスにパブリックIPアドレスを割り振る
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-a"
    Created_by = "Terraform"
  }
}

### PrivateSubnet
resource "aws_subnet" "private_a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "priv-a"
    Created_by = "Terraform"
  }
}

########################################################
### RDS用サブネット ###
########################################################
resource "aws_subnet" "dbsub_a" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "db-subnet-1a"
    Created_by = "Terraform"
  }
}

resource "aws_subnet" "dbsub_c" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "db-subnet-1c"
    Created_by = "Terraform"
  }
}

# ALB's subnet
resource "aws_subnet" "public_c" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "ap-northeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "pub-c"
    Created_by = "Terraform"
  }
}