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
  source = "git@github.com:dvsp-itransition/terraform-modules.git//simple_network"
  vpc_cidr    = var.vpc_cidr
  region      = var.region
  environment = var.environment
}

