variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "AWS_KEY_PAIR_NAME" {
  description = "AWS key pair name"
  type        = string
}