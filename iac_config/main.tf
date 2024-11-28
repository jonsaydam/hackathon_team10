terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.77.0"
    }
  }
}

module "team10_network" {
  source      = "mtlmtfe01.mgmt.interac.ca/DevSecOpsHackathon/team10_network/aws"
  version     = "1.0.0"
  cidr_block  = var.cidr_block
  env         = var.app_environment
  region      = var.region
  vpc_enabled = true
  vpc_name    = local.vpc_name
  azs         = var.azs
}
