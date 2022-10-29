# ElasticIPの設定
resource "aws_eip" "ngw_pub_a" {
  vpc = true
  tags = {
    Name = "ngw-pub-a"
    Created_by = "Terraform"
  }
}