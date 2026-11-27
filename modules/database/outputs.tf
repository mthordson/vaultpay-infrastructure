output "db_endpoint" {
  value = aws_db_instance.vaultpay.address

}

output "db_port" {
  value = aws_db_instance.vaultpay.port
}

output "db_name" {
  value = aws_db_instance.vaultpay.db_name
}

output "db_security_group_id" {
  value = aws_security_group.rds.id
}

output "db_master_secret_arn" {
  value = aws_db_instance.vaultpay.master_user_secret[0].secret_arn
}