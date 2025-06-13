resource "aws_instance" "webapp" {
  ami           = "ami-0c02fb55956c7d316" # Ubuntu 22.04 us-east-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.devops_key.key_name

  vpc_security_group_ids = ["sg-005cad66d8508e0a"] # փոխիր ըստ քո group-ի ID-ի

  tags = {
    Name = "WebAppEC2"
  }
}
