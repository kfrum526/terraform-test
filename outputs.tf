output "route_table_id" {
  value = module.vpc.default_route_table_id
}

output "kms_key_id" {
  value = module.kms_key.key_id
}