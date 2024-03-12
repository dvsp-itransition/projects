# -------------------
# General variables
# -------------------
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

# ---------------
# EC2 variables
# ---------------
variable "ami" {
  type        = list(string)
  description = "A list of AMI IDs to use for the instances."
}

variable "instance_name" {
  type        = list(string)
  default     = ["docker"]
  description = "A list of names for the instance(s)."
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance"
  type        = list(any)
  default = [{
    volume_size = "30"
    }
  ]
}

variable "user_data" {
  description = "The user data to provide when launching the instance."
  type        = list(string)
}

variable "instance_type" {
  type        = list(string)
  description = "A list of instance types to launch."
}

variable "subnet_id" {
  type        = list(string)
  description = "A list of subnet IDs where the instances will be launched."
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to associate with the instances."
}

variable "key_pair" {
  description = "Name of the key pair public."
  type        = list(string)
}

# --------------------
# Key-pair variables
# --------------------
variable "key_name" {
  description = "Name of the key pair."
  type        = list(string)
}

variable "private_key_algorithm" {
  description = "Algorithm used for generating the private key."
  default     = ["RSA"]
  type        = list(string)
}

variable "private_key_rsa_bits" {
  description = "the size of the generated RSA key, in bits"
  default     = [4096]
  type        = list(number)
}

variable "key_pair_permission" {
  description = "Permission to set for the private key file."
  default     = [400]
  type        = list(number)
}

variable "private_key_path" {
  description = "Path to the private key file."
  default     = ["./dev.pem"]
  type        = list(string)
}

variable "public_key_path" {
  description = "Path to the public key file."
  default     = ["./dev"]
  type        = list(string)
}


