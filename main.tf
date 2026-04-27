module "VPC" {
  source = "./modules/vpc"
  vpc_name = "My VPC"
}

module "route" {
  source = "./modules/route-table"
  vpc_id = module.VPC.vpc_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = module.VPC.ig_id
}

module "Subnet_private" {
  source = "./modules/subnet"
  vpc_id = module.VPC.vpc_id
  sub_cidr_block = "10.2.0.0/24"
  availability_zone = "us-east-1a"
  subnet_name = "Private Subnet"
  map_public_ip_on_launch = false
}

module "Subnet_public" {
  source = "./modules/subnet"
  vpc_id = module.VPC.vpc_id
  sub_cidr_block = "10.2.1.0/24"
  availability_zone = "us-east-1b"
  subnet_name = "Public Subnet"
  map_public_ip_on_launch = true
}