resource "aws_route" "igw" {
  route_table_id         = var.vpc_id.main.default_route_table_id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = var.gateway_id
}