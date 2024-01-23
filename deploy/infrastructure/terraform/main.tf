terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.20"
    }
  }
}

provider "aws" {
  region = var.region
}

module "security_group" {
  source = "./tf_modules/security_group"

  sg_name     = "Common SG"
  common_tags = local.common_tags
}

module "ec2_keypair" {
  source = "./tf_modules/keypair"

  key_name        = "laravel"
  public_key_path = var.public_key_path
  common_tags     = local.common_tags
}

module "ec2_instance" {
  source = "./tf_modules/ec2"

  instance_name     = "laravel-autodeploy-server"
  instance_type     = "t3.medium"
  ansible_script    = "../ansible/server.yml"
  security_group_id = module.security_group.sg_id

  private_key_path = var.private_key_path
  public_key_name  = module.ec2_keypair.public_key_name
  common_tags      = local.common_tags
}
