variable "cidr_block" {
    description = "VPC CIDR"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of VPC"
  type = string
}

