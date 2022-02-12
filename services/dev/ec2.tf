resource "aws_instance" "dev" {
  count                       = 1
  subnet_id                   = data.terraform_remote_state.network_dev.outputs.dev_subnet_public_ids[0]
  ami                         = var.dev_ec2_instance_image
  instance_type               = var.dev_ec2_instance_type
  key_name                    = var.service
  vpc_security_group_ids      = [aws_security_group.dev_ec2_instance.id]
  iam_instance_profile        = var.dev_ec2_instance_is_ssm_login ? var.ssm_iam_instance_profile : null
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = var.dev_ec2_instance_volume_size
  }

  tags = var.dev_scheduler_tag_resource
}
