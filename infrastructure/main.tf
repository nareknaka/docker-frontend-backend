provider "aws" {
  region     = var.region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default public subnet (first available)
data "aws_subnets" "default_public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

# Check if security group already exists
data "aws_security_groups" "existing_webapp_sg" {
  filter {
    name   = "group-name"
    values = ["webapp-security-group"]
  }
  
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "webapp_sg" {
  count = length(data.aws_security_groups.existing_webapp_sg.ids) == 0 ? 1 : 0
  
  name        = "webapp-security-group"
  description = "Security group for webapp allowing web traffic"
  vpc_id      = data.aws_vpc.default.id  # Specify VPC
  
  # Allow React app (port 3000)
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow backend (port 5000)
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow SSH (port 22)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "WebApp-SecurityGroup"
  }
}

# Get the correct security group ID (existing or newly created)
locals {
  security_group_id = length(data.aws_security_groups.existing_webapp_sg.ids) > 0 ? data.aws_security_groups.existing_webapp_sg.ids[0] : aws_security_group.webapp_sg[0].id
}

resource "aws_instance" "webapp" {
  ami                         = "ami-0e86e20dae90224ad"  # Ubuntu 22.04 LTS
  instance_type               = "t2.micro"
  key_name                    = var.AWS_KEY_PAIR_NAME
  vpc_security_group_ids      = [local.security_group_id]
  subnet_id                   = data.aws_subnets.default_public.ids[0]  # Use default public subnet
  associate_public_ip_address = true  # Ensure public IP

  # Pre-install Docker and dependencies
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io docker-compose awscli curl wget
              systemctl start docker
              systemctl enable docker
              usermod -aG docker ubuntu
              mkdir -p /home/ubuntu/app
              chown ubuntu:ubuntu /home/ubuntu/app
              EOF

  tags = {
    Name = "WebAppEC2"
  }
}

# Outputs
output "webapp_public_ip" {
  description = "Public IP address of the webapp EC2 instance" 
  value       = aws_instance.webapp.public_ip
}

output "instance_public_ip" {
  description = "Public IP for CD pipeline"
  value       = aws_instance.webapp.public_ip
}

output "webapp_private_ip" {
  description = "Private IP address of the webapp EC2 instance"
  value       = aws_instance.webapp.private_ip
}

output "vpc_id" {
  description = "VPC ID"
  value       = data.aws_vpc.default.id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = data.aws_subnets.default_public.ids[0]
}