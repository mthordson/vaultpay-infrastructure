variable "project_name" {
  description = "Project name used in all Name and Project tags"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC containing the ALB, target groups, and security groups"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the Application Load Balancer"
  type        = list(string)
}

variable "app_private_subnet_ids" {
  description = "List of private subnet IDs for the Auto Scaling Group"
  type        = list(string)
}

variable "app_security_group_id" {
  description = "ID of the application security group defined in the root module"
  type        = string
}

variable "db_master_secret_arn" {
  description = "ARN of the Secrets Manager secret containing the database password"
  type        = string
}

variable "db_endpoint" {
  description = "Hostname of the database instance"
  type        = string
}

variable "db_port" {
  description = "Port used to connect to the database"
  type        = number
}

variable "db_name" {
  description = "Name of the application database"
  type        = string
}

variable "image_tag" {
  description = "Tag of the container image to deploy from ECR"
  type        = string
}

variable "ecr_force_delete" {
  description = "Allow deletion of the ECR repository even when it contains images"
  type        = bool
}

variable "s3_force_destroy" {
  description = "Allow destruction of the S3 bucket even when it contains objects"
  type        = bool
}
