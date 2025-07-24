variable "kubernetes_version" {
  default     = 1.27
  description = "kubernetes version"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "default CIDR range of the VPC"
}

variable "aws_region" {
  default = "ap-south-1"
  description = "aws region"
}

variable "iam_role" {
  default = "Jenkins-EC2-role"
  description = "Service Role for EC2"
}

variable "iam_instance_profile" {
  default = "Jenkins-Instance_Profile"
  description = "Instance Profile for EC2"
}

variable "key_name" {
  default = "Jenkins-key-pair"
  description = "key pair for EC2"
}
