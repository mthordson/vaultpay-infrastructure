provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"

  project_name             = var.project_name
  vpc_cidr                 = var.vpc_cidr
  public_subnet_cidrs      = var.public_subnet_cidrs
  app_private_subnet_cidrs = var.app_private_subnet_cidrs
  db_private_subnet_cidrs  = var.db_private_subnet_cidrs
}

module "database" {
  source = "./modules/database"

  project_name               = var.project_name
  vpc_id                     = module.vpc.vpc_id
  db_subnet_ids              = module.vpc.db_private_subnet_ids
  app_security_group_id      = aws_security_group.app.id
  db_multi_az                = var.db_multi_az
  db_backup_retention_period = var.db_backup_retention_period
  db_deletion_protection     = var.db_deletion_protection
  db_skip_final_snapshot     = var.db_skip_final_snapshot
}

resource "aws_security_group" "app" {
  name        = "${lower(var.project_name)}-app-sg"
  description = "Security group for the Vaultpay app instances"
  vpc_id      = module.vpc.vpc_id



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${lower(var.project_name)}-app-sg"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "app_from_alb" {
  security_group_id            = aws_security_group.app.id
  referenced_security_group_id = module.application.alb_security_group_id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  description                  = "HTTP from the ALB"
}


module "application" {
  source = "./modules/application"

  project_name           = var.project_name
  vpc_id                 = module.vpc.vpc_id
  public_subnet_ids      = module.vpc.public_subnet_ids
  app_private_subnet_ids = module.vpc.app_private_subnet_ids
  app_security_group_id  = aws_security_group.app.id
  db_master_secret_arn   = module.database.db_master_secret_arn
  db_endpoint            = module.database.db_endpoint
  db_port                = module.database.db_port
  db_name                = module.database.db_name
  image_tag              = var.image_tag
  ecr_force_delete       = var.ecr_force_delete
  s3_force_destroy       = var.s3_force_destroy
}
