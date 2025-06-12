variable "region" {
  description = "AWS region to deploy in"
  default     = "us-east-1"
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  default     = "devops-key"
}

variable "private_key_path" {
  description = "Path to your private key file (.pem)"
  default     = "devops-key.pem"
}
