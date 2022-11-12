# DBサブネット
resource "aws_db_subnet_group" "db_subgrp" {
  name = "db-subgrp"
  subnet_ids = [aws_subnet.dbsub_a.id, aws_subnet.dbsub_c.id]

  tags = {
    Name = "db-subnet-group"
    Created_by = "Terraform"
  }
}

# 