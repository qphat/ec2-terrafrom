# EC2 Instance outputs
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "instance_arn" {
  description = "ARN of the EC2 instance"
  value       = aws_instance.web_server.arn
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.web_server.private_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.web_server.public_dns
}

output "instance_private_dns" {
  description = "Private DNS name of the EC2 instance"
  value       = aws_instance.web_server.private_dns
}

output "instance_availability_zone" {
  description = "Availability zone of the EC2 instance"
  value       = aws_instance.web_server.availability_zone
}

output "instance_state" {
  description = "State of the EC2 instance"
  value       = aws_instance.web_server.instance_state
}

output "instance_type" {
  description = "Type of the EC2 instance"
  value       = aws_instance.web_server.instance_type
}

output "root_block_device" {
  description = "Root block device information"
  value       = aws_instance.web_server.root_block_device
}
