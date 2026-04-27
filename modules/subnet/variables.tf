variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "sub_cidr_block" {
  description = "Subnet CIDR"
  type = string
}

variable "availability_zone" {
  description = "Availability Zone"
  type = string
}

variable "map_public_ip_on_launch" {
  description = "Whether or not the subnet is private or public"
  type = bool
}

variable "subnet_name" {
  description = "Name for the subnet"
  type = string
}

variable "route_table_id" {
  description = "Route table ID to associate with the subnet"
  type = string
}