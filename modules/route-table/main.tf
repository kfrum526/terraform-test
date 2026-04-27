resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
}

resource "aws_route" "igw" {
  route_table_id         = aws_route_table.this.id
  destination_cidr_block = var.destination_cidr_block
  gateway_id             = var.gateway_id
}