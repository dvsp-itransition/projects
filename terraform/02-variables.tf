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