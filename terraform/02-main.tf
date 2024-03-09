module "network" {
  source      = "git@github.com:dvsp-itransition/terraform-module-network.git"
  region      = var.region
  environment = var.environment

  azs               = var.azs
  vpc_cidr          = var.vpc_cidr
  public_subnets    = var.public_subnets
  private_subnets   = var.private_subnets
  data_base_subnets = var.data_base_subnets
}