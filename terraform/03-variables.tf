variable "region" {
  default     = "us-east-2"
  type        = string
  description = "The region where the infrastructure will be deployed"
}

variable "environment" {
  default     = "dev"
  type        = string
  description = "The environment for which the infrastructure is intended (e.g., dev, test, prod)"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "CIDR block for VPC"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 65534))
    error_message = "Must be valid IPv4 CIDR with netmask of /16. for example: 10.0.0.0/16"
  }
}

variable "azs" {
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
  description = "Availability Zones to deploy resources"
}

variable "public_subnets" {
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
  description = "Subnets for hosting public-facing resources"
}

variable "private_subnets" {
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.21.0/24"]
  description = "Subnets for hosting private resources (non-database)"
}

variable "data_base_subnets" {
  type        = list(string)
  default     = ["10.0.12.0/24", "10.0.22.0/24"]
  description = "Subnets for hosting private database resources"
}




