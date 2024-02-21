// Local variables definition for Networking
locals {
  region              = "eu-central-1"
  vpc_main_cidr_block = "172.31.0.0/16"
  public_subnets_cidr = {
    "${local.region}a" = "172.31.20.0/24"
    "${local.region}b" = "172.31.21.0/24"
    "${local.region}c" = "172.31.22.0/24"
  }
}

# ------------------------------------------------------------------------------
# Modules Calls
# ------------------------------------------------------------------------------

// Main VPC creation
module "vpc" {
  source = "../modules/networking"

  vpc_cidr_block   = local.vpc_main_cidr_block
  pub_subnets_cidr = local.public_subnets_cidr
}