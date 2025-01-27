variable "aws_region" {
  description = "AWS region to deploy resources"
  type = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment"
  type = string
}

variable "project_name" {
  description = "Name of the project"
  type = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type = string
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type= list(string)

}

variable "availability_zones" {
  description = "Availability zones to use"
  type= list(string)
}


variable "num_public_subnets" {
  description = "Number of public subnets"
  type = number
}
