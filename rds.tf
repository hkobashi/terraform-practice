# DBサブネットグループ
resource "aws_db_subnet_group" "db_subgrp" {
  name = "db-subgrp"
  subnet_ids = [aws_subnet.dbsub_a.id, aws_subnet.dbsub_c.id]

  tags = {
    Name = "db-subnet-group"
    Created_by = "Terraform"
  }
}

# DBクラスター用パラメーターグループ
resource "aws_rds_cluster_parameter_group" "db_clstr_pmtgrp" {
  name = "db-clstr-pmtgrp"
  # DBエンジンを指定
  family = "aurora-mysql5.7"

  description = "RDS Cluster Parameter Group"

  parameter {
    name = "character_set_server"
    value = "utf8"
  }
  parameter {
    name = "character_set_client"
    value = "utf8"
  }

  parameter {
    name = "time_zone"
    value = "Asia/Tokyo"
    apply_method = "immediate"
  }
}

# DBインスタンス用パラメーターグループ
resource "aws_db_parameter_group" "db_pmtgrp" {
  name = "db-pmtgrp"
  family = "aurora-mysql5.7"
  description = "RDS Instance Parameter Group"

}

# RDSクラスター設定
resource "aws_rds_cluster" "aurora_clstr" {
  cluster_identifier = "aurora-cluster"
  # 初期作成されるスキーマ
  database_name = "mydb"

  # 管理ユーザー情報
  master_username = "admin"
  master_password = "1234Admin5678"
  port = 3306 # 使用ポート
  apply_immediately = false

  skip_final_snapshot = true

  engine = "aurora-mysql"
  engine_version = "5.7.mysql_aurora.2.07.2"

  # 使用するセキュリティグループを定義
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.db_subgrp.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.db_clstr_pmtgrp.name

  tags = {
    Name = "aurora-cluster"
    Created_by = "Terraform"
  }
}

