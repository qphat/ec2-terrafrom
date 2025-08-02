# Security group outputs
output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web_sg.id
}

output "security_group_name" {
  description = "Name of the security group"
  value       = aws_security_group.web_sg.name
}

output "security_group_arn" {
  description = "ARN of the security group"
  value       = aws_security_group.web_sg.arn
}

output "security_group_vpc_id" {
  description = "VPC ID of the security group"
  value       = aws_security_group.web_sg.vpc_id
}
