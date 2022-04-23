output "iam_role_ecs_task_execution_role" {
  value = aws_iam_role.ecs_task_execution_role
}

output "iam_role_ecs_task_role" {
  value = aws_iam_role.ecs_task_role
}

output "iam_role_explorer_ecs_task_execution_role" {
  value = aws_iam_role.explorer_ecs_task_execution_role
}

output "iam_role_explorer_ecs_task_role" {
  value = aws_iam_role.explorer_ecs_task_role
}

output "iam_role_ssm_role" {
  value = aws_iam_role.ssm_role
}

output "iam_role_chatbot" {
  value = aws_iam_role.chatbot
}

output "iam_role_lambda_edge_role" {
  value = aws_iam_role.lambda_edge_role
}

output "iam_role_tf_plan" {
  value = aws_iam_role.tf_plan
}

output "iam_role_ssm_role_ec2" {
  value = aws_iam_role.ssm_role_ec2
}

output "aws_iam_instance_profile" {
  value = aws_iam_instance_profile.ssm_role_ec2
}
