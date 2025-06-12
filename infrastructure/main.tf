provider "aws" {
  region = var.region
}

resource "aws_key_pair" "devops_key" {
  key_name   = var.key_name
  public_key = file("devops-key.pub") # ⚠️ համոզվիր, որ ունես այս ֆայլը
}

resource "aws_security_group" "web_sg" {
  name        = "webapp-sg"
  description = "Allow SSH and app ports"
  vpc_id      = "default"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "webapp" {
  ami                         = "ami-0c02fb55956c7d316" # Ubuntu 22.04 us-east-1
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.devops_key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web_sg.id]

  tags = {
    Name = "TerraformEC2"
  }

  provisioner "remote-exec" {
    inline = [
      "echo Instance provisioned"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }
}

output "ec2_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.webapp.public_ip
}
