provider "aws" {
  region     = var.region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

resource "aws_key_pair" "devops-key-rotated" {
  key_name = var.KEY_NAME
  public_key = file("${path.module}/devops-key.pub")
}

resource "aws_instance" "webapp" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.devops-key-rotated.key_name
  vpc_security_group_ids = ["sg-005cad66d86508e0a"]
  subnet_id              = "subnet-0beba1805554e5c57"


  tags = {
    Name = "WebAppEC2"
  }
}
