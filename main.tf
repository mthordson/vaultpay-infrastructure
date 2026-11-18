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
  app_private_subnet_cidrs   = var.app_private_subnet_cidrs
  db_multi_az                = var.db_multi_az
  db_backup_retention_period = var.db_backup_retention_period
  db_deletion_protection     = var.db_deletion_protection
  db_skip_final_snapshot     = var.db_skip_final_snapshot
}