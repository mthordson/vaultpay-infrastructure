output "ecr_repository_url" {
  description = "URL of the ECR repository holding the Vaultpay container image.  Use this when pushing an image manually with docker"
  value       = module.application.ecr_repository_url
}

output "runtime_bucket_name" {
  description = "Name of the S3 bucket holding Vaultpay runtime data."
  value       = module.application.runtime_bucket_name
}

output "alb_dns_name" {
  description = "Public DNS name of the VaultPay ALB"
  value       = module.application.alb_dns_name
}