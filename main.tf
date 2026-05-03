module "vpc" {
  source = "./modules/vpc"
  vpc_name = "My VPC"
}

resource "aws_route" "default_igw" {
  route_table_id         = module.vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.vpc.ig_id
}

module "Subnet_private" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
  sub_cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  subnet_name = "Private Subnet"
  map_public_ip_on_launch = false
  route_table_id = module.vpc.default_route_table_id
}

module "Subnet_public" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
  sub_cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  subnet_name = "Public Subnet"
  map_public_ip_on_launch = true
  route_table_id = module.vpc.default_route_table_id
}

data "aws_caller_identity" "current" {}

module "kms_key" {
  source                  = "./modules/kms"
  description             = "Symmetric encryption key for application data"
  alias_name              = "alias/app-encryption-key"
  deletion_window_in_days = 20
  key_admins              = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/Alice"]
  key_users               = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/Bob"]
}