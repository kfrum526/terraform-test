resource "aws_route" "igw" {
  route_table_id         = output.rtb_id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = output.ig_id
}