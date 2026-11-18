variable "project_name" {
  description = "Project name used in all Name and Project tags"
  type        = string
}

variable "vpc_id" {
  description = "ID for the VPC"
  type        = string
}

variable "db_subnet_ids" {
  description = "Database Subnet ID"
  type        = list(string) 
}

variable "app_private_subnet_cidrs" {
  description = "CIDR block for the app private subnets"
  type        = list(string)
}

variable "db_multi_az" {
  description = "Single-AZ vs Multi-AZ"
  type        = bool
}

variable "db_backup_retention_period" {
  description = "Days of the backups to keep"
  type        = number
}

variable "db_deletion_protection" {
  description = "Stops accidental deletes"
  type        = bool
}

variable "db_skip_final_snapshot" {
  description = "Whether a snapshot is taken on destroy"
  type        = bool
}

