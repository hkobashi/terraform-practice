### Webサーバーで使用するssh鍵の設定
# ssh鍵の設定
data "template_file" "ssh_key" {
  template = file("/Users/hkobashi/.ssh/id_rsa.pub")
}

resource "aws_key_pair" "auth" {
  key_name = "id_rsa.pub"
  # 使用する公開鍵を指定
  public_key = data.template_file.ssh_key.rendered
}

### APサーバーで使用するssh鍵の設定
# ssh鍵の設定
data "template_file" "ssh_key_priv" {
  template = file("/Users/hkobashi/.ssh/id_rsa_priv.pub")
}

resource "aws_key_pair" "auth_priv" {
  key_name = "id_rsa_priv.pub"
  # 使用する公開鍵を指定
  public_key = data.template_file.ssh_key_priv.rendered
}