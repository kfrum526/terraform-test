variable "cidr_block" {
    description = "VPC CIDR"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of VPC"
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

variable "public_ip" {
  description = "Public IP"
  type = bool
}

variable "private_ip" {
  description = "Private IP"
  type = bool
}

variable "subnet_id" {
  description = "subnet id"
  type = bool
}