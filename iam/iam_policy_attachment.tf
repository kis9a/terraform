## group
### admin
resource "aws_iam_group_policy_attachment" "group_admin_administrator_access" {
  group      = aws_iam_group.admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

### admin_mfa
resource "aws_iam_group_policy_attachment" "group_admin_mfa_administrator_access" {
  group      = aws_iam_group.admin_mfa.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_policy_attachment" "group_admin_mfa_required" {
  group      = aws_iam_group.admin_mfa.name
  policy_arn = aws_iam_policy.mfa_required.arn
}

### limitation_region_tokyo
resource "aws_iam_group_policy_attachment" "limitation_region_tokyo" {
  group      = aws_iam_group.limitation_region_tokyo.name
  policy_arn = aws_iam_policy.limitation_region_tokyo.arn
}

### limitation_region_osaka
resource "aws_iam_group_policy_attachment" "limitation_region_osaka" {
  group      = aws_iam_group.limitation_region_osaka.name
  policy_arn = aws_iam_policy.limitation_region_osaka.arn
}

## readonly
resource "aws_iam_group_policy_attachment" "group_readonly_readonly_access" {
  group      = aws_iam_group.readonly.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

## user
resource "aws_iam_user_policy_attachment" "user_admin_tokyo_limitation_region_tokyo" {
  user       = aws_iam_user.admin_tokyo.name
  policy_arn = aws_iam_policy.limitation_region_tokyo.arn
}

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

### role
resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.lambda_edge_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
