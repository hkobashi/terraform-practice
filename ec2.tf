### Webサーバー
# 当tfファイルと同じディレクトリにあるweb.sh.tplをdata化
data "template_file" "web_shell" {
  template = file("${path.module}/web.sh.tpl")
}

resource "aws_instance" "web" {
  ami = data.aws_ami.amzn2.id # 使用するAMIを指定
  instance_type = "t2.micro" # インスタンスタイプ
  key_name = aws_key_pair.auth.id # 使用するキーペア
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  # パブリックサブネットに所属させる
  subnet_id = aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.pub_a.id]
  root_block_device {
    volume_type = "gp2"
    volume_size = "8" # EBS最小サイズは8GB
    delete_on_termination = true # EC2削除と同時にEBSも削除する
  }
  tags = {
    Name = "web-instance"
    Created_by = "Terraform"
  }
  # ユーザーデータを指定
  user_data = base64encode(data.template_file.web_shell.rendered)
}

### APサーバー
data "template_file" "ap_shell" {
  template = file("${path.module}/ap.sh.tpl")
}

resource "aws_instance" "ap" {
  ami = data.aws_ami.amzn2.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.auth_priv.id
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  subnet_id = aws_subnet.public_a.id
  vpc_security_group_ids = [aws_security_group.pub_a.id]
  root_block_device {
    volume_type = "gp2"
    volume_size = "8"
    delete_on_termination = true
  }
  tags = {
    Name = "ap-instance"
    Created_by = "Terraform"
  }
  user_data = base64encode(data.template_file.ap_shell.rendered)
}