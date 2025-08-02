# Configure the AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure AWS Provider
provider "aws" {
  region = var.aws_region
}

# Data source to get the latest Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Security Module
module "security" {
  source = "./modules/security"

  vpc_id       = data.aws_vpc.default.id
  project_name = var.project_name
  environment  = var.environment

  # Optional: customize allowed CIDR blocks
  # allowed_ssh_cidr   = ["YOUR_IP/32"]  # Restrict SSH to your IP
  # allowed_http_cidr  = ["0.0.0.0/0"]
  # allowed_https_cidr = ["0.0.0.0/0"]
}

# Compute Module
module "compute" {
  source = "./modules/compute"

  ami_id             = data.aws_ami.ubuntu.id
  instance_type      = var.instance_type
  key_name          = var.key_name
  security_group_ids = [module.security.security_group_id]
  project_name      = var.project_name
  environment       = var.environment
  enable_monitoring = var.enable_monitoring
  root_volume_size  = var.root_volume_size

  # Optional: specify subnet for private deployment
  # subnet_id                   = "subnet-xxxxxxxxx"
  # associate_public_ip_address = false
}