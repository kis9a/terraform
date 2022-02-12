module "me_kis9a" {
  source              = "../../modules/redirector"
  host_zone_id        = var.host_zone_id.kis9a
  fqdn                = var.fqdn.me_kis9a
  redirect_target     = var.redirect_target.me_kis9a
  ssl_certificate_arn = data.terraform_remote_state.domains.outputs.sub_kis9a_virginia_ssl_arn
  force_destroy       = var.force_destroy.is
  tags                = var.tags.me
}

module "dot_kis9a" {
  source              = "../../modules/redirector"
  host_zone_id        = var.host_zone_id.kis9a
  fqdn                = var.fqdn.dot_kis9a
  redirect_target     = var.redirect_target.dot_kis9a
  ssl_certificate_arn = data.terraform_remote_state.domains.outputs.sub_kis9a_virginia_ssl_arn
  force_destroy       = var.force_destroy.is
  tags                = var.tags.dot
}

module "zenn_kis9a" {
  source              = "../../modules/redirector"
  host_zone_id        = var.host_zone_id.kis9a
  fqdn                = var.fqdn.zenn_kis9a
  redirect_target     = var.redirect_target.zenn_kis9a
  ssl_certificate_arn = data.terraform_remote_state.domains.outputs.sub_kis9a_virginia_ssl_arn
  force_destroy       = var.force_destroy.is
  tags                = var.tags.zenn
}

module "tf_kis9a" {
  source              = "../../modules/redirector"
  host_zone_id        = var.host_zone_id.kis9a
  fqdn                = var.fqdn.tf_kis9a
  redirect_target     = var.redirect_target.tf_kis9a
  ssl_certificate_arn = data.terraform_remote_state.domains.outputs.sub_kis9a_virginia_ssl_arn
  force_destroy       = var.force_destroy.is
  tags                = var.tags.tf
}

module "gh_kis9a" {
  source              = "../../modules/redirector"
  host_zone_id        = var.host_zone_id.kis9a
  fqdn                = var.fqdn.gh_kis9a
  redirect_target     = var.redirect_target.gh_kis9a
  ssl_certificate_arn = data.terraform_remote_state.domains.outputs.sub_kis9a_virginia_ssl_arn
  force_destroy       = var.force_destroy.is
  tags                = var.tags.gh
}

module "tw_kis9a" {
  source              = "../../modules/redirector"
  host_zone_id        = var.host_zone_id.kis9a
  fqdn                = var.fqdn.tw_kis9a
  redirect_target     = var.redirect_target.tw_kis9a
  ssl_certificate_arn = data.terraform_remote_state.domains.outputs.sub_kis9a_virginia_ssl_arn
  force_destroy       = var.force_destroy.is
  tags                = var.tags.tw
}
