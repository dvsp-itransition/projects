resource "aws_instance" "this" {
  for_each      = var.vms
  ami           = each.value.ami
  instance_type = each.value.type
  key_name      = var.environment

  root_block_device {
    volume_size = each.value.volumeSize
  }

  tags = {
    Name        = "${var.environment}-${each.key}"
    environment = var.environment
  }

  depends_on = [ aws_key_pair.keypair ]
}

variable "environment" {  
  default = "dev"
  type        = string
  description = "The environment for which the infrastructure is intended (e.g., dev, test, prod)"
}

variable "vms" {
  type        = map
  description = "The list of virtual machines (VMs) with their configurations."

  default = {
    vm = {
      ami        = "ami-0d18e50ca22537278"
      type       = "t2.micro"
      volumeSize = 8            
    }
  }
}

# Key-pairs for VMs
resource "tls_private_key" "tf-priv-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# private key
resource "local_sensitive_file" "pem_file" {
  filename        = pathexpand("/tmp/${var.environment}.pem")
  file_permission = "400"
  content         = tls_private_key.tf-priv-key.private_key_pem
}

# public key
resource "aws_key_pair" "keypair" {
  key_name   = var.environment
  public_key = tls_private_key.tf-priv-key.public_key_openssh
}

variable "key_name" {
  default = "dev"
}

# Security Group
resource "aws_security_group" "this" { 

  # name   = "ELB-SG-TF" 
  # vpc_id = var.vpc_id

  ingress { 
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-${each.key}-SG"
    environment = var.environment
  }
}


output "vm-public-ips" {
  value = {
    for key, vm in aws_instance.this : key => vm.public_ip
  }
}

output "vm-private_ips" {
  value = {
    for key, vm in aws_instance.this : key => vm.private_ip
  }
}




