output "public_1_ip" {
  value = aws_instance.iac_1_instance.public_ip
}

output "public_2_ip" {
  value = aws_instance.iac_2_instance.public_ip
}
output "rds_endpoint" {
  value = aws_db_instance.rds_wordpress.endpoint
}
output "rds_username" {
  value = aws_db_instance.rds_wordpress.username
}
÷˘

÷
