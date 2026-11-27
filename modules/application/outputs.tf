output "ecr_repository_url" {
  description = "URL of the VaultPay ECR repository"
  value       = aws_ecr_repository.vaultpay.repository_url
}

output "runtime_bucket_name" {
  description = "Name of the S3 bucket used for application runtime storage"
  value       = aws_s3_bucket.runtime.id
}

output "alb_dns_name" {
  description = "DNS hostname of the Application Load Balancer"
  value       = aws_lb.app.dns_name
}

output "alb_security_group_id" {
  description = "ID of the security group attached to the Application Load Balancer"
  value       = aws_security_group.alb.id
}
