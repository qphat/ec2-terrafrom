# AWS region
variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-west-2"
}

# EC2 instance type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
  
  validation {
    condition = contains([
      "t3.micro", "t3.small", "t3.medium", "t3.large",
      "t2.micro", "t2.small", "t2.medium", "t2.large"
    ], var.instance_type)
    error_message = "Instance type must be a valid t2 or t3 instance type."
  }
}

# Key pair name for SSH access
variable "key_name" {
  description = "AWS key pair name for SSH access"
  type        = string
  default     = "my-terraform-key"
}

# Environment tag
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
}

# Project name
variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "terraform-sample"
}

# Enable detailed monitoring
variable "enable_monitoring" {
  description = "Enable detailed monitoring for EC2 instance"
  type        = bool
  default     = true
}

# Root volume size
variable "root_volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  default     = 20
  
  validation {
    condition     = var.root_volume_size >= 8 && var.root_volume_size <= 100
    error_message = "Root volume size must be between 8 and 100 GB."
  }
}
