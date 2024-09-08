variable "key_name" {
  description = "The name for the SSH key pair"
  type        = string
  default     = "demo-key"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0d53d72369335a9d6" # Example AMI ID for Amazon Linux 2
}
