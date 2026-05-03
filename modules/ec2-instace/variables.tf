variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for the EC2 instance"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile to associate with the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access to the EC2 instance"
  type        = string
}
variable "security_groups" {
  description = "List of security group IDs to associate with the EC2 instance"
  type        = list(string)
}

variable "user_data" {
  description = "User data script to run on instance launch"
  type        = string
}

variable "volume_size" {
  description = "Size of the EBS volume in GB"
  type        = number
}

variable "kms_key_id" {
  description = "KMS key ID to use for encrypting the EBS volume"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}