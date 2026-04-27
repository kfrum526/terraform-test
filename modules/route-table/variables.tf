variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "destination_cidr_block" {
  description = "Destination CIDR block for route"
  type = string
}

variable "gateway_id" {
  description = "Gateway ID for the route"
  type = string
}