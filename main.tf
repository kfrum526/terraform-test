## Calls module to make VPC; This is the main VPC
module "vpc" {
  source = "./modules/vpc"
  vpc_name = "My VPC"
}

## Route for internet gateway
resource "aws_route" "default_igw" {
  route_table_id         = module.vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.vpc.ig_id
}

## Calls module to make subnets; one public and one private
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

## Calls current caller identity to get account ID for KMS key policy
data "aws_caller_identity" "current" {}


## Calls module to make KMS key for encrypting application data
module "kms_key" {
  source                  = "./modules/kms"
  description             = "Symmetric encryption key for application data"
  alias_name              = "alias/app-key"
  deletion_window_in_days = 20
  key_admins              = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/kfrum.adm"]
  key_users               = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/kfrum.adm"]
}

## Creates policy document for administrator role
data "aws_iam_policy_document" "administrator" {
  statement {
    actions   = ["*"]
    resources = ["*"]
  }
}

## Calls module to make IAM role for administrator
module "aws_iam_role" {
  source = "./modules/IAM"
  role_name = "Administrator_Role"
  policy_name = "Administrator_Policy"
  policy_document = data.aws_iam_policy_document.administrator.json
}