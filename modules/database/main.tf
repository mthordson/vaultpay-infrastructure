resource "aws_db_subnet_group" "vaultpay" {
  name        = "vaultpay-db-subnet-group"
  description = "Subnets available for VaultPay RDS database placement"
  subnet_ids  = var.db_subnet_ids

  tags = {
    Name    = "vaultpay-db-subnet-group"
    Project = var.project_name
  }
}

resource "aws_security_group" "rds" {
  name        = "vaultpay-rds-sg"
  description = "Security group for the Vaultpay RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "vaultpay-rds-sg"
    Project = var.project_name
  }
}

resource "aws_db_instance" "vaultpay" {
  engine                      = "postgres"
  engine_version              = "18"
  instance_class              = "db.t4g.micro"
  allocated_storage           = 20
  storage_type                = "gp3"
  storage_encrypted           = true
  publicly_accessible         = false
  db_name                     = "vaultpay"
  username                    = "postgres"
  manage_master_user_password = true
  db_subnet_group_name        = aws_db_subnet_group.vaultpay.name
  vpc_security_group_ids      = [aws_security_group.rds.id]
  multi_az                    = var.db_multi_az
  backup_retention_period     = var.db_backup_retention_period
  deletion_protection         = var.db_deletion_protection
  skip_final_snapshot         = var.db_skip_final_snapshot
  final_snapshot_identifier   = "vaultpay-db-final-snapshot"
  identifier                  = "vaultpay-db"

  tags = {
    Name    = "vaultpay-rds-db"
    Project = var.project_name
  }
}   