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