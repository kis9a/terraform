module "dot_kis9a" {
  source              = "../modules/redirector"
  host_zone_id        = var.host_zone_id.kis9a
  fqdn                = var.fqdn.dot_kis9a
  redirect_target     = var.redirect_target.dot_kis9a
  ssl_certificate_arn = var.ssl_certificate_arn.sub_kis9a
  force_destroy       = var.force_destroy.is
  tags                = var.dot_kis9a_tags
}

module "zenn_kis9a" {
  source              = "../modules/redirector"
  host_zone_id        = var.host_zone_id.kis9a
  fqdn                = var.fqdn.zenn_kis9a
  redirect_target     = var.redirect_target.zenn_kis9a
  ssl_certificate_arn = var.ssl_certificate_arn.sub_kis9a
  force_destroy       = var.force_destroy.is
  tags                = var.zenn_kis9a_tags
}

module "tf_kis9a" {
  source              = "../modules/redirector"
  host_zone_id        = var.host_zone_id.kis9a
  fqdn                = var.fqdn.tf_kis9a
  redirect_target     = var.redirect_target.tf_kis9a
  ssl_certificate_arn = var.ssl_certificate_arn.sub_kis9a
  force_destroy       = var.force_destroy.is
  tags                = var.tf_kis9a_tags
}

module "gh_kis9a" {
  source              = "../modules/redirector"
  host_zone_id        = var.host_zone_id.kis9a
  fqdn                = var.fqdn.gh_kis9a
  redirect_target     = var.redirect_target.gh_kis9a
  ssl_certificate_arn = var.ssl_certificate_arn.sub_kis9a
  force_destroy       = var.force_destroy.is
  tags                = var.gh_kis9a_tags
}
