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
