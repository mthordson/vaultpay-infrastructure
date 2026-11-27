output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}

output "app_private_subnet_ids" {
  description = "List of app-private subnet IDs"
  value       = [aws_subnet.app_private_a.id, aws_subnet.app_private_b.id]
}

output "db_private_subnet_ids" {
  description = "List of db-private subnet IDs"
  value       = [aws_subnet.db_private_a.id, aws_subnet.db_private_b.id]
}
