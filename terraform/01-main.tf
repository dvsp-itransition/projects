terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.39.0, <= 5.39.9"
    }
  }
  
  required_version = ">= 1.6.0, <= 1.6.9" # terraform
}

provider "aws" {
  region = var.region
}

# module "network" {  
#   source = "./modules/network"
#   vpc_cidr    = var.vpc_cidr
#   region      = var.region
#   environment = var.environment    
# }


# module "network" {
#   source = "git@github.com:dvsp-itransition/terraform-module-network.git"
#   vpc_cidr    = var.vpc_cidr
#   region      = var.region
#   environment = var.environment
# }

# module "vms" {
#   source      = "./modules/terraform-vm"
#   key_name    = var.key_name
#   environment = var.environment
#   vms         = var.vms
# }

# variable "vms" {
#   type        = map
#   description = "The list of virtual machines (VMs) with their configurations."

#   default = {
#     vm = {
#       ami        = "ami-0d18e50ca22537278"
#       type       = "t2.micro"
#       volumeSize = 8      
#     }
#   }
# }

# variable "instance_object" {
#   type = list(object({
#     name = string
#     enabled = bool
#     instance_type = string
#     env = string
#   }))
#   default = [
#   {
#     name = "instance A"
#     enabled = true
#     instance_type = "t2.micro"
#     env = "dev"
#   },
#   {
#     name = "instance B"
#     enabled = false
#     instance_type = "t2.micro"
#     env = "prod"
#   },
#   ]
# }

# variable "key_name" {
#   type = string
#   default     = "dev"
#   description = "The SSH key pair that would be used for accessing the instances."
# }

