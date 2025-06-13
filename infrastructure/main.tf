resource "aws_key_pair" "devops_key" {
  key_name   = var.key_name
  public_key = var.public_key_content
}

connection {
  type        = "ssh"
  user        = "ubuntu"
  private_key = var.private_key_content
  host        = self.public_ip
}
