module "key_pair" {
  source                = "git@github.com:dvsp-itransition/terraform-module-key-pairs.git"
  key_name              = var.key_name
  private_key_algorithm = var.private_key_algorithm
  private_key_rsa_bits  = var.private_key_rsa_bits
  key_pair_permission   = var.key_pair_permission
  private_key_path      = var.private_key_path
  public_key_path       = var.public_key_path
}

module "ec2_instance" {
  source                 = "git@github.com:dvsp-itransition/terraform-module-EC2.git"
  ami                    = var.ami
  environment            = var.environment
  key_pair               = try(var.key_pair, null)
  user_data              = var.user_data
  instance_type          = var.instance_type
  instance_name          = var.instance_name
  subnet_id              = try(var.subnet_id, null)
  vpc_security_group_ids = try(var.vpc_security_group_ids, null)
  root_block_device      = var.root_block_device
  depends_on             = [module.key_pair]
}

