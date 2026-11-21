variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDR block for the public subnets"
  type        = list(string)
}


variable "app_private_subnet_cidrs" {
  description = "CIDR block for the app private subnets"
  type        = list(string)
}

variable "db_private_subnet_cidrs" {
  description = "CIDR blocks for the db private subnets"
  type        = list(string)
}

variable "project_name" {
  description = "Project name used in all Name and Project tags"
  type        = string
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

variable "ecr_force_delete" {
  description = "Ecr forcefully deleted"
  type        = bool
  default     = false
}
variable "s3_force_destroy" {
  description = "S3 forcefully destroyed"
  type        = bool
  default     = false
}