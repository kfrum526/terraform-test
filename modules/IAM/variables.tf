variable "role_name" {
  description = "Name for the IAM role"
  type        = string
}

variable "policy_name" {
  description = "Name for the inline policy attached to the IAM role"
  type        = string
}

variable "policy_document" {
  description = "JSON policy document, must be created from data source aws_iam_policy_document or call JSON file with file() function"
  type        = string
}