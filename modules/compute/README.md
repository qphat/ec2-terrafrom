# Compute Module

This module creates and manages EC2 instances for the web server infrastructure.

## Resources Created

- **EC2 Instance**: Web server instance with Ubuntu 22.04 LTS
- **EBS Volume**: Encrypted root volume with configurable size

## Features

- **Auto-Configuration**: Apache web server automatically installed via user data
- **Monitoring**: Optional detailed CloudWatch monitoring
- **Encryption**: Root volume encryption enabled by default
- **Tagging**: Consistent tagging strategy
- **Flexible Networking**: Supports public and private deployment

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| ami_id | AMI ID for the EC2 instance | string | - | yes |
| instance_type | EC2 instance type | string | - | yes |
| key_name | AWS key pair name for SSH access | string | - | yes |
| security_group_ids | List of security group IDs | list(string) | - | yes |
| project_name | Project name for resource naming | string | - | yes |
| environment | Environment name | string | - | yes |
| enable_monitoring | Enable detailed monitoring for EC2 instance | bool | true | no |
| root_volume_size | Size of the root EBS volume in GB | number | 20 | no |
| subnet_id | Subnet ID for the EC2 instance | string | null | no |
| associate_public_ip_address | Associate a public IP address with the instance | bool | true | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | ID of the EC2 instance |
| instance_arn | ARN of the EC2 instance |
| instance_public_ip | Public IP address of the EC2 instance |
| instance_private_ip | Private IP address of the EC2 instance |
| instance_public_dns | Public DNS name of the EC2 instance |
| instance_private_dns | Private DNS name of the EC2 instance |
| instance_availability_zone | Availability zone of the EC2 instance |
| instance_state | State of the EC2 instance |
| instance_type | Type of the EC2 instance |
| root_block_device | Root block device information |

## Usage

```hcl
module "compute" {
  source = "./modules/compute"

  ami_id             = data.aws_ami.ubuntu.id
  instance_type      = "t3.micro"
  key_name          = "my-key-pair"
  security_group_ids = [module.security.security_group_id]
  project_name      = "my-project"
  environment       = "production"
  
  # Optional configurations
  enable_monitoring = true
  root_volume_size  = 30
  
  # For private deployment
  subnet_id                   = "subnet-xxxxxxxxx"
  associate_public_ip_address = false
}
```

## User Data Script

The module includes a user data script that:

1. Updates the system packages
2. Installs Apache web server
3. Starts and enables Apache service
4. Creates a sample HTML page with instance information

## Storage

- **Volume Type**: GP3 (General Purpose SSD)
- **Encryption**: Enabled by default
- **Size**: Configurable (default: 20GB)
- **Performance**: Optimized for general workloads
