variable "region" {
  default = "us-east-1"
}

variable "key_name" {
  description = "Name of the AWS EC2 key pair"
  default     = "devops-key"
}

variable "private_key_path" {
  description = "Path to your private key file"
  default     = "../devops-key.pem"
}
