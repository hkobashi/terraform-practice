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

