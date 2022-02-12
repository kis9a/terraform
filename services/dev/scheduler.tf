## ec2
module "stop_ec2_instance" {
  source                         = "diodonfrost/lambda-scheduler-stop-start/aws"
  name                           = "${var.service}-ec2-instance-stop"
  cloudwatch_schedule_expression = "cron(0 16 * * ? *)"
  schedule_action                = "stop"
  ec2_schedule                   = "true"
  scheduler_tag                  = var.dev_scheduler_tag
}

module "start_ec2_instance" {
  source                         = "diodonfrost/lambda-scheduler-stop-start/aws"
  name                           = "${var.service}-ec2-instance-start"
  cloudwatch_schedule_expression = "cron(0 0 * * ? *)"
  schedule_action                = "start"
  ec2_schedule                   = "true"
  scheduler_tag                  = var.dev_scheduler_tag
}

## rds
module "stop_rds_instance" {
  source                         = "diodonfrost/lambda-scheduler-stop-start/aws"
  name                           = "${var.service}-rds-instance-stop"
  cloudwatch_schedule_expression = "cron(0 16 * * ? *)"
  schedule_action                = "stop"
  rds_schedule                   = "true"
  scheduler_tag                  = var.dev_scheduler_tag
}

module "start_rds_instance" {
  source                         = "diodonfrost/lambda-scheduler-stop-start/aws"
  name                           = "${var.service}-rds-instance-start"
  cloudwatch_schedule_expression = "cron(0 0 * * ? *)"
  schedule_action                = "start"
  rds_schedule                   = "true"
  scheduler_tag                  = var.dev_scheduler_tag
}
