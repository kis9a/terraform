module "bastion" {
  source                   = "../../../modules/bastion"
  env                      = var.env
  service                  = var.service
  bastion_instance_type    = var.bastion_instance_type
  bastion_instance_image   = var.bastion_instance_image
  ssm_iam_instance_profile = var.ssm_iam_instance_profile
  subnet_public_ids        = data.terraform_remote_state.network_dev.outputs.dev_subnet_public_ids
  vpc_id                   = data.terraform_remote_state.network_dev.outputs.dev_vpc_id
}
