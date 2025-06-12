provider "aws" {
  region = var.region
}

resource "aws_instance" "webapp" {
  ami                    = "ami-0c02fb55956c7d316" # Ubuntu 22.04 us-east-1
  instance_type          = "t2.micro"
  key_name               = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = ["sg-005cad66d86508e0a"]

  tags = {
    Name = "WebAppEC2"
  }

  provisioner "remote-exec" {
    inline = ["echo Instance provisioned!"]
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${path.module}/devops-key.pem")
    host        = self.public_ip
  }
}
