resource "aws_db_subnet_group" "vaultpay" {
  name    = "vaultpay-db-subnet-group"
  description = "Subnets available for VaultPay RDS database placement"
  subnet_ids  = module.vpc.db_private_subnet_ids

  tags = {
    Name    = "vaultpay-db-subnet-group"
    Project = var.project_name
  }
}

resource "aws_security_group" "rds" {
  name = "vaultpay-rds-sg"
  description = "Security group for the Vaultpay RDS instance"
  vpc_id = module.vpc.vpc_id

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vaultpay-rds-sg"
    Project = var.project_name
  }
}
  