variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "KEY_NAME" {
  description = "Name of the key pair"
}

variable "PUBLIC_KEY_CONTENT" {
  description = "Public key content from GitHub secret"
}

variable "PRIVATE_KEY_CONTENT" {
  description = "Private key content from GitHub secret"
}
