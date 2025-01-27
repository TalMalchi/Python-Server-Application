terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket  = "tal-terraform"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

locals {
  environment         = "sandbox"
  num_public_subnets  = 1
}

module "vpc" {
  source               = "./modules/vpc"
  aws_region           = var.aws_region
  environment          = local.environment
  num_public_subnets   = local.num_public_subnets
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  availability_zones   = var.availability_zones
  project_name         = var.project_name
}


module "ec2" {
  source       = "./modules/ec2"
  depends_on                = [module.vpc]
  ami_id       = var.ami_id
  instance_type = var.instance_type
  subnet_id    = module.vpc.public_subnet_ids[0]
  allowed_ssh_cidr = var.public_subnet_cidrs
  vpc_id = module.vpc.vpc_id
  project_name = var.project_name
  environment  = local.environment
}

