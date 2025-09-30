variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "AWS_KEY_PAIR_NAME" {
  description = "SSH key pair name for EC2 access"
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key ID from GitHub secret"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Access Key from GitHub secret"
}
