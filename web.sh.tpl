#!/bin/bash
# Webサーバーで使用するユーザーデータ
yum update -y
amazon-linux-extras enable nginx1
yum clean metadata
yum install nginx -y
systemctl start nginx.service