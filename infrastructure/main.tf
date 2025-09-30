provider "aws" {
  region     = var.region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}


resource "aws_security_group" "webapp_sg" {
  name        = "webapp-security-group"
  description = "Security group for webapp allowing web traffic"
  
  # Allow React app (port 3000)
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Allow API (port 3001)
  ingress {
    from_port   = 3001
    to_port     = 3001
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

resource "aws_instance" "webapp" {
  ami                         = "ami-0c02fb55956c7d316"
  instance_type               = "t2.micro"
  key_name                    = var.AWS_KEY_PAIR_NAME
  vpc_security_group_ids      = [aws_security_group.webapp_sg.id]
  subnet_id                   = "subnet-0beba1805554e5c57"

  tags = {
    Name = "WebAppEC2"
  }
}

output "webapp_public_ip" {
  description = "Public IP address of the webapp EC2 instance" 
  value       = aws_instance.webapp.public_ip
}

output "webapp_private_ip" {
  description = "Private IP address of the webapp EC2 instance"
  value       = aws_instance.webapp.private_ip
}