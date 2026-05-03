variable "key_alias" {
  description = "Alias for the KMS key"
  type        = string
  default     = "alias/my-key"
  
}

variable "description" {
  description = "Description for the KMS key"
  type        = string
  default     = "KMS key for encrypting sensitive data"
}

variable "deletion_window_in_days" {
  description = "Number of days before the KMS key is deleted after being scheduled for deletion"
  type        = number
  default     = 30
}

variable "key_admins" {
  description = "List of IAM ARNs that will have administrative permissions on the KMS key"
  type        = list(string)
  default     = []
}

variable "key_users" {
  description = "List of IAM ARNs that will have usage permissions on the KMS key"
  type        = list(string)
  default     = []
}