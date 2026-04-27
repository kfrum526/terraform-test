output "vpc_id" {
  value = aws_vpc.main.id
}

output "default_route_table_id" {
  value = aws_vpc.main.main_route_table_id
}

output "ig_id" {
  value = aws_internet_gateway.gw.id
}