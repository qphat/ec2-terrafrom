# Create EC2 instance
resource "aws_instance" "web_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = var.security_group_ids
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  
  # User data script to install Apache web server
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Hello from Terraform!</h1>" > /var/www/html/index.html
              echo "<p>Instance ID: $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>" >> /var/www/html/index.html
              echo "<p>Environment: ${var.environment}</p>" >> /var/www/html/index.html
              echo "<p>Project: ${var.project_name}</p>" >> /var/www/html/index.html
              echo "<p>Module: compute</p>" >> /var/www/html/index.html
              EOF

  # Enable detailed monitoring
  monitoring = var.enable_monitoring

  # EBS block device
  root_block_device {
    volume_type = "gp3"
    volume_size = var.root_volume_size
    encrypted   = true
    
    tags = {
      Name        = "${var.project_name}-web-server-root-volume"
      Environment = var.environment
      Project     = var.project_name
      Module      = "compute"
    }
  }

  tags = {
    Name        = "${var.project_name}-web-server"
    Environment = var.environment
    Project     = var.project_name
    Module      = "compute"
  }
}
