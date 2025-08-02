# Security Module

This module creates and manages security groups for the web server infrastructure.

## Resources Created

- **Security Group**: Web server security group with configurable ingress/egress rules

## Features

- **SSH Access**: Port 22 (configurable CIDR blocks)
- **HTTP Access**: Port 80 (configurable CIDR blocks)  
- **HTTPS Access**: Port 443 (configurable CIDR blocks)
- **Outbound Traffic**: All outbound traffic allowed
- **Tagging**: Consistent tagging strategy

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| vpc_id | VPC ID where security group will be created | string | - | yes |
| project_name | Project name for resource naming | string | - | yes |
| environment | Environment name | string | - | yes |
| allowed_ssh_cidr | CIDR blocks allowed for SSH access | list(string) | ["0.0.0.0/0"] | no |
| allowed_http_cidr | CIDR blocks allowed for HTTP access | list(string) | ["0.0.0.0/0"] | no |
| allowed_https_cidr | CIDR blocks allowed for HTTPS access | list(string) | ["0.0.0.0/0"] | no |

## Outputs

| Name | Description |
|------|-------------|
| security_group_id | ID of the security group |
| security_group_name | Name of the security group |
| security_group_arn | ARN of the security group |
| security_group_vpc_id | VPC ID of the security group |

## Usage

```hcl
module "security" {
  source = "./modules/security"

  vpc_id       = data.aws_vpc.default.id
  project_name = "my-project"
  environment  = "production"
  
  # Restrict SSH access to specific IP
  allowed_ssh_cidr = ["203.0.113.0/32"]
}
```

## Security Considerations

- **SSH Access**: Default allows SSH from anywhere (0.0.0.0/0). Consider restricting to specific IP addresses.
- **Web Traffic**: HTTP/HTTPS access is open by default for web server functionality.
- **Outbound**: All outbound traffic is allowed for system updates and web service functionality.
