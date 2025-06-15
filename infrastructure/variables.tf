variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "key_name" {
  description = "Name of the key pair"
}

variable "public_key_content" {
  description = "Public key content from GitHub secret"
}

variable "private_key_content" {
  description = "Private key content from GitHub secret"
}
