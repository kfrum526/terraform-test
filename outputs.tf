output "route_table_id" {
  value = module.vpc.default_route_table_id
}

output "key_arn" {
  value = module.kms_key.key_arn
}

output "key_id" {
  value = module.kms_key.key_id
}