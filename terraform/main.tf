terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0" # min provider version    
    }
  }

  required_version = ">= 0.13" # min Terraform version
}

provider "aws" {
  region = var.region
}

module "network" {  
  source      = "git::https://github.com/dvsp-itransition/terraform-module-network.git"
  vpc_cidr    = var.vpc_cidr
  region      = var.region
  environment = var.environment
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for VPC"
}

variable "region" {
  default     = "eu-west-2"
  type        = string
  description = "The region where the infrastructure will be deployed"
}

variable "environment" {
  default     = "dev"
  type        = string
  description = "The environment for which the infrastructure is intended (e.g., dev, test, prod)"
}

output "vpc_id" {
  value = module.network.vpc_id
}