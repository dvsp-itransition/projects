variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "CIDR block for VPC"

  validation {
    condition     = cidrnetmask(var.vpc_cidr) == "255.255.0.0"
    error_message = "The provided CIDR block must have a netmask of /16"
  }
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