variable "sub_cidr_block" {
  description = "Subnet CIDR"
  type = bool
}

variable "availability_zone" {
  description = "Availability Zone"
  type = string
}

variable "map_public_ip_on_launch" {
  description = "Whether or not the subnet is private or public"
  type = string
}

variable "subnet_name" {
  description = "Name for the subnet"
  type = string
}