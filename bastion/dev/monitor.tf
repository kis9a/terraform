# module "monitor" {
#   source                   = "../../modules/monitor"
#   env                      = var.env
#   service                  = var.service
#   subnet_app_cidr          = data.terraform_remote_state.network_dev.outputs.dev_subnet_app_cidr
#   subnet_public_cidr       = data.terraform_remote_state.network_dev.outputs.dev_subnet_public_cidr
#   monitor_instance_type    = var.monitor_instance_type
#   monitor_instance_image   = var.monitor_instance_image
#   vpc_id                   = data.terraform_remote_state.network_dev.outputs.dev_vpc_id
#   subnet_app_id            = data.terraform_remote_state.network_dev.outputs.dev_subnet_app_ids[0]
#   is_ssm_login             = true
#   ssm_iam_instance_profile = var.ssm_iam_instance_profile
# }
