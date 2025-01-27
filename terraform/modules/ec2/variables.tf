variable "ami_id" {
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
}

variable "subnet_id" {
  description = "Subnet ID where the EC2 instance will be deployed"
}

variable "vpc_id" {
  description = "VPC ID where the EC2 instance will be deployed"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed for SSH access"
  default     = "0.0.0.0/0" # Adjust to restrict access
}

variable "environment" {
  description = "Environment tag (e.g., dev, prod)"
}

variable "project_name" {
  description = "Project name for tagging resources"
}
