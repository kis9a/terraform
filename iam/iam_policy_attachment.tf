resource "aws_iam_user_policy_attachment" "user_frontend_s3_full_access" {
  user       = aws_iam_user.frontend.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_user_policy_attachment" "user_frontend_cloudfront_full_access" {
  user       = aws_iam_user.frontend.name
  policy_arn = "arn:aws:iam::aws:policy/CloudFrontFullAccess"
}

resource "aws_iam_user_policy_attachment" "amazon_ecs_task_execution_role_policy" {
  user       = aws_iam_user.ecs_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_user_policy_attachment" "secrets_manager_read_write" {
  user       = aws_iam_user.ecs_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

resource "aws_iam_user_policy_attachment" "amazon_elasti_cache_full_access" {
  user       = aws_iam_user.ecs_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElastiCacheFullAccess"
}

resource "aws_iam_user_policy_attachment" "amazon_s3_full_access" {
  user       = aws_iam_user.ecs_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_user_policy_attachment" "aws_code_deploy_role_for_ecs" {
  user       = aws_iam_user.ecs_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}

resource "aws_iam_user_policy_attachment" "amazon_ses_full_access" {
  user       = aws_iam_user.ecs_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSESFullAccess"
}

resource "aws_iam_user_policy_attachment" "amazon_rds_data_full_access" {
  user       = aws_iam_user.ecs_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSDataFullAccess"
}

resource "aws_iam_user_policy_attachment" "amazon_ssm_read_only_access" {
  user       = aws_iam_user.ecs_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}
