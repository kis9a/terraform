output "lambda_qualified_arn" {
  value       = "${module.lambda.lambda_qualified_arn}"
  description = "Lambda function ARN with version"
}

output "lambda_version" {
  value = "${module.lambda.lambda_version}"
}

output "lambda_arn" {
  value = "${module.lambda.lambda_arn}"
}
