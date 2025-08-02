# ================================
# COMPUTE MODULE OUTPUTS
# ================================

# EC2 Instance Information
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.compute.instance_id
}

output "instance_arn" {
  description = "ARN of the EC2 instance"
  value       = module.compute.instance_arn
}

output "instance_type" {
  description = "Type of the EC2 instance"
  value       = module.compute.instance_type
}

output "instance_state" {
  description = "Current state of the EC2 instance"
  value       = module.compute.instance_state
}

# Network Information
output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.compute.instance_public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.compute.instance_private_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = module.compute.instance_public_dns
}

output "instance_private_dns" {
  description = "Private DNS name of the EC2 instance"
  value       = module.compute.instance_private_dns
}

output "instance_availability_zone" {
  description = "Availability zone of the EC2 instance"
  value       = module.compute.instance_availability_zone
}

# Storage Information
output "root_block_device" {
  description = "Root block device information"
  value       = module.compute.root_block_device
  sensitive   = false
}

# ================================
# SECURITY MODULE OUTPUTS
# ================================

# Security Group Information
output "security_group_id" {
  description = "ID of the security group"
  value       = module.security.security_group_id
}

output "security_group_name" {
  description = "Name of the security group"
  value       = module.security.security_group_name
}

output "security_group_arn" {
  description = "ARN of the security group"
  value       = module.security.security_group_arn
}

output "security_group_vpc_id" {
  description = "VPC ID of the security group"
  value       = module.security.security_group_vpc_id
}

# ================================
# CONVENIENCE OUTPUTS
# ================================

# Web Server Access
output "web_server_url" {
  description = "URL to access the web server"
  value       = module.compute.instance_public_ip != null ? "http://${module.compute.instance_public_ip}" : "No public IP assigned"
}

output "ssh_connection_command" {
  description = "SSH command to connect to the instance"
  value       = module.compute.instance_public_ip != null ? "ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${module.compute.instance_public_ip}" : "No public IP assigned"
}

# Resource Summary
output "deployment_summary" {
  description = "Summary of deployed resources"
  value = {
    project_name      = var.project_name
    environment       = var.environment
    aws_region        = var.aws_region
    instance_id       = module.compute.instance_id
    instance_type     = module.compute.instance_type
    public_ip         = module.compute.instance_public_ip
    security_group_id = module.security.security_group_id
    availability_zone = module.compute.instance_availability_zone
  }
}
