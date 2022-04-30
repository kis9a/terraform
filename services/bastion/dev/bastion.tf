module "bastion" {
  source         = "../../../modules/bastion"
  env            = var.env
  service        = var.service
  subnet_ids     = data.terraform_remote_state.network.outputs.dev_subnet_app_ids
  vpc_id         = data.terraform_remote_state.network.outputs.dev_vpc_id
  ecr_image_url  = "${data.terraform_remote_state.ecr.outputs.bastion_repository_url}:v1.0"
  ecs_cluster_id = data.terraform_remote_state.ecs.outputs.cluster_dev.arn
}
