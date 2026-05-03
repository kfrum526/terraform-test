data "aws_caller_identity" "current" {}

resource "aws_kms_key" "this" {
  description             = var.description
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = true
  policy                  = templatefile("${path.module}/kms_policy.json", {
    account_id = data.aws_caller_identity.current.account_id
    key_admins = var.key_admins
    key_users  = var.key_users
  })
}

resource "aws_kms_alias" "this" {
  name          = var.alias_name
  target_key_id = aws_kms_key.this.key_id
}