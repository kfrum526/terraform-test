resource "aws_subnet" "this" {
  vpc_id     = var.vpc_id
  cidr_block = var.sub_cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_route_table_association" "example" {
  subnet_id      = aws_subnet.this.id
  route_table_id = var.route_table_id
}