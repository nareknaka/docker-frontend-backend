provider "aws" {
  region = var.region
}

resource "aws_key_pair" "devops_key" {
  key_name   = var.key_name
  public_key = var.public_key_content
}

resource "aws_instance" "webapp" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu Server 22.04 LTS (us-east-1)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.devops_key.key_name

  vpc_security_group_ids = ["sg-005cad66d8508e0a"]

  tags = {
    Name = "WebAppEC2"
  }
}
