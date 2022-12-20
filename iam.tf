### EC2用IAM Roleの定義
resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"
  path = "/"
  # Roleに紐づけるポリシーを定義
  assume_role_policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Action":"sts:AssumeRole",
      "Principal":{
        "Service":"ec2.amazonaws.com"
      },
      "Effect":"Allow",
      "Sid":""
    }
  ]
}
EOF
  tags = {
    Name = "ec2-role"
    Created_by = "Terraform"
  }
}

# EC2が使用するIAMRoleを定義
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# role for EC2 to access to S3
resource "aws_iam_role_policy_attachment" "ec2_s3_fullaccess" {
  role = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}