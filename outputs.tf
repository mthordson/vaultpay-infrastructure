output "ecr_repository_url" {
  description = "URL of the ECR repository holding the Vaultpay container image.  Use this when pushing an image manually with docker"
  value       = aws_ecr_repository.vaultpay.repository_url
}

output "runtime_bucket_name" {
  description = "Name of the S3 bucket holding Vaultpay runtime data."
  value       = aws_s3_bucket.runtime.id
}

output "alb_dns_name" {
  description = "Public DNS name of the VaultPay ALB"
  value       = aws_lb.app.dns_name
}