provider "aws" {
  region = var.region
}

resource "aws_instance" "webapp" {
  ami                         = "ami-0c02fb55956c7d316" # Ubuntu 22.04 us-east-1
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = ["sg-005cad66d8508e0a"]

  tags = {
    Name = "WebAppEC2"
  }

  provisioner "remote-exec" {
    inline = ["echo Instance provisioned!"]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = var.private_key_content
    host        = self.public_ip
  }
}
