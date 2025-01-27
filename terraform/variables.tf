
variable "project_name" {
  description = "Project name for tagging"
  type        = string

}

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-west-2"
  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]+$", var.aws_region))
    error_message = "AWS region must be a valid format (e.g., us-west-2)."
  }
}


variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.vpc_cidr))
    error_message = "VPC CIDR must be a valid CIDR format."
  }
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}


variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a"]
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}


