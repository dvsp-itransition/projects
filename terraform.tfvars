# -------------------
# General variables
# -------------------
region      = "us-east-2"
environment = "dev"

# ---------------
# EC2 variables
# ---------------
ami                    = ["ami-0b4750268a88e78e0"]
instance_name          = ["webapp"]
key_pair               = ["dev"]
instance_type          = ["t2.micro"]
root_block_device      = [{ volume_size = "20" }]
user_data              = ["null"]
subnet_id              = [null]
vpc_security_group_ids = ["sg-063abf19099d9b045"]

# --------------------
# Key-pair variables
# --------------------
key_name              = ["dev"]
private_key_algorithm = ["RSA"]
private_key_rsa_bits  = [4096]
key_pair_permission   = [400]
private_key_path      = ["./dev.pem"]
public_key_path       = ["./dev"]







