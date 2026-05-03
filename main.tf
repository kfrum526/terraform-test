## Calls module to make VPC; This is the main VPC
module "vpc" {
  source   = "./modules/vpc"
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

  vpc_id                  = module.vpc.vpc_id
  sub_cidr_block          = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  subnet_name             = "Private Subnet"
  map_public_ip_on_launch = false
  route_table_id          = module.vpc.default_route_table_id
}
module "Subnet_public" {
  source = "./modules/subnet"

  vpc_id                  = module.vpc.vpc_id
  sub_cidr_block          = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  subnet_name             = "Public Subnet"
  map_public_ip_on_launch = true
  route_table_id          = module.vpc.default_route_table_id
}

## Calls current caller identity to get account ID for KMS key policy
data "aws_caller_identity" "current" {}


## Calls module to make KMS key for encrypting application data
module "kms_key" {
  source = "./modules/kms"

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
module "administrator_role" {
  source = "./modules/IAM"

  role_name       = "Administrator_Role"
  policy_name     = "Administrator_Policy"
  policy_document = data.aws_iam_policy_document.administrator.json
}

#######################################################################
######################### Security Groups #############################
#######################################################################

module "private_sg" {
  source = "./modules/security_groups"

  sg_name = "Private_SG"
  vpc_id  = module.vpc.vpc_id
  ingress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "tcp"
      cidr_blocks      = ["10.0.0.0/24"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}

module "public_sg" {
  source = "./modules/security_groups"

  sg_name = "Public_SG"
  vpc_id  = module.vpc.vpc_id
  ingress = [
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}



#######################################################################
########################### EC2 Instances #############################
#######################################################################

module "bastion_instance" {
  source = "./modules/ec2-instance"

  ami_id               = "ami-0798c9ebaf695e14e" # Windows 2025 base
  instance_type        = "t3.micro"
  subnet_id            = module.Subnet_public.subnet_id
  iam_instance_profile = module.administrator_role.role_name
  key_name             = "In_S3_Bucket"
  security_groups      = [module.public_sg.sg_id]
  user_data            = "" #file("${path.module}/user_data.sh")
  volume_size          = 20
  kms_key_id           = module.kms_key.key_id
  instance_name        = "Terraform-Test"
}

module "Private_ec2" {
  source = "./modules/ec2-instance"

  ami_id               = "ami-0c94855ba95c71c99" # Amazon Linux 2 AMI
  instance_type        = "t3.micro"
  subnet_id            = module.Subnet_private.subnet_id
  iam_instance_profile = module.administrator_role.role_name
  key_name             = "In_S3_Bucket"
  security_groups      = [module.private_sg.sg_id]
  user_data            = "" #file("${path.module}/user_data.sh")
  volume_size          = 20
  kms_key_id           = module.kms_key.key_id
  instance_name        = "Private_EC2"
}