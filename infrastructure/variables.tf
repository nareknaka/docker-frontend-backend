variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "KEY_NAME" {
  description = "SSH key name"
}

variable "PUBLIC_KEY_CONTENT" {
  description = "SSH public key content from GitHub secret"
}

variable "PRIVATE_KEY_CONTENT" {
  description = "Private key content from GitHub secret"
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key ID from GitHub secret"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Access Key from GitHub secret"
}
