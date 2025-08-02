# Terraform EC2 Instance Template - Modular Architecture

This Terraform template creates an EC2 instance on AWS using a modular architecture with separate compute and security modules.

## Architecture

The template is organized into two main modules:

- **Security Module** (`modules/security/`): Manages security groups and network access rules
- **Compute Module** (`modules/compute/`): Manages EC2 instances and storage

## Features

- **Modular Design**: Separate modules for compute and security resources
- **EC2 Instance**: Ubuntu 22.04 LTS with configurable instance type
- **Security Group**: Configured for SSH (22), HTTP (80), and HTTPS (443) access
- **Web Server**: Automatically installs Apache web server with a sample page
- **Encrypted Storage**: Root volume with encryption enabled
- **Monitoring**: Optional detailed monitoring
- **Flexible Deployment**: Supports both public and private deployments
- **Comprehensive Outputs**: Detailed information about all created resources

## Module Structure

```
.
├── main.tf                           # Main configuration using modules
├── variables.tf                      # Root-level variables
├── outputs.tf                       # Root-level outputs (module aggregation)
├── terraform.tfvars.example         # Example variables file
├── README.md                        # This file
└── modules/
    ├── security/                     # Security module
    │   ├── main.tf                  # Security group resources
    │   ├── variables.tf             # Security module variables
    │   ├── outputs.tf               # Security module outputs
    │   └── README.md                # Security module documentation
    └── compute/                      # Compute module
        ├── main.tf                  # EC2 instance resources
        ├── variables.tf             # Compute module variables
        ├── outputs.tf               # Compute module outputs
        └── README.md                # Compute module documentation
```

## Prerequisites

1. **AWS CLI**: Install and configure AWS CLI with your credentials
2. **Terraform**: Install Terraform (version 1.0 or later)
3. **AWS Key Pair**: Create an EC2 key pair in your AWS region for SSH access

## Quick Start

1. **Clone or copy the files** to your local directory

2. **Configure variables** (optional):
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```
   Edit `terraform.tfvars` with your specific values.

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Plan the deployment**:
   ```bash
   terraform plan
   ```

5. **Apply the configuration**:
   ```bash
   terraform apply
   ```

6. **Access your web server**:
   After deployment, use the output URL to access your web server.

## Configuration

### Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `aws_region` | AWS region | `us-west-2` | No |
| `instance_type` | EC2 instance type | `t3.micro` | No |
| `key_name` | AWS key pair name | `my-key-pair` | Yes* |
| `environment` | Environment name | `development` | No |
| `project_name` | Project name | `terraform-sample` | No |
| `enable_monitoring` | Enable detailed monitoring | `true` | No |
| `root_volume_size` | Root volume size (GB) | `20` | No |

*You must update the `key_name` variable with your actual key pair name.

### Customization

To customize the deployment, you can:

1. **Edit variables**: Modify `variables.tf` or create a `terraform.tfvars` file
2. **Change security groups**: Update the security group rules in `main.tf`
3. **Modify user data**: Update the user data script to install different software
4. **Add resources**: Extend the template with additional AWS resources

## Outputs

After successful deployment, Terraform will output:

- Instance ID
- Public IP address
- Private IP address
- Public DNS name
- Availability zone
- Security group ID
- Web server URL

## Security Considerations

⚠️ **Important Security Notes**:

1. **SSH Access**: The security group allows SSH access from anywhere (0.0.0.0/0). Consider restricting this to your IP address:
   ```hcl
   cidr_blocks = ["YOUR_IP_ADDRESS/32"]
   ```

2. **Key Pair**: Ensure you have the private key file (.pem) for the specified key pair

3. **AWS Credentials**: Never commit AWS credentials to version control

## Cleanup

To destroy the resources:

```bash
terraform destroy
```

## File Structure

```
.
├── main.tf                           # Main configuration using modules
├── variables.tf                      # Root-level variables
├── outputs.tf                       # Root-level outputs (module aggregation)
├── terraform.tfvars.example         # Example variables file
├── README.md                        # This file
└── modules/
    ├── security/                     # Security module
    │   ├── main.tf                  # Security group resources
    │   ├── variables.tf             # Security module variables
    │   ├── outputs.tf               # Security module outputs
    │   └── README.md                # Security module documentation
    └── compute/                      # Compute module
        ├── main.tf                  # EC2 instance resources
        ├── variables.tf             # Compute module variables
        ├── outputs.tf               # Compute module outputs
        └── README.md                # Compute module documentation
```

## Module Benefits

- **Reusability**: Modules can be easily reused across different projects
- **Maintainability**: Separation of concerns makes code easier to maintain
- **Testing**: Individual modules can be tested independently
- **Scalability**: Easy to extend with additional modules (networking, monitoring, etc.)
- **Version Control**: Modules can be versioned and shared independently

## Enhanced Outputs

The modular structure provides comprehensive outputs organized by category:

### Compute Module Outputs
- Instance information (ID, ARN, type, state)
- Network details (public/private IPs, DNS names)
- Storage information (root block device details)

### Security Module Outputs
- Security group details (ID, name, ARN)
- VPC information

### Convenience Outputs
- Web server URL
- SSH connection command
- Deployment summary

## Troubleshooting

### Common Issues

1. **Key pair not found**: Ensure the key pair exists in the specified AWS region
2. **AWS credentials**: Verify AWS CLI is configured or environment variables are set
3. **Region availability**: Some instance types may not be available in all regions

### Useful Commands

```bash
# Check Terraform version
terraform version

# Validate configuration
terraform validate

# Format code
terraform fmt

# Show current state
terraform show

# List resources
terraform state list
```

## Cost Estimation

The default configuration uses:
- **t3.micro instance**: ~$8-10/month (eligible for AWS Free Tier)
- **20GB gp3 storage**: ~$2/month
- **Data transfer**: Variable based on usage

Use the [AWS Pricing Calculator](https://calculator.aws/) for detailed cost estimates.
