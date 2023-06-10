# AMIの設定
# AMIの作成者がaws以外のものを除外
data "aws_ami" "amzn2" {
  most_recent = true # 最新版を使用
  # AMI作成者がaws以外のものを除外
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-x86_64-gp2" ]
  }
}