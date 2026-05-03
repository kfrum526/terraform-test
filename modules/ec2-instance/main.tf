resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id    = var.subnet_id
  iam_instance_profile = var.iam_instance_profile
  key_name = var.key_name
  security_groups = var.security_groups
  user_data = var.user_data

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = var.volume_size
    volume_type = "gp2"
    encrypted   = true
    kms_key_id  = var.kms_key_id
  }
  

  tags = {
    Name = var.instance_name
  }
}