output "lambda_qualified_arn" {
  value       = "${aws_lambda_function.basic_auth.qualified_arn}"
  description = "Lambda function ARN with version"
}

output "lambda_version" {
  value = "${aws_lambda_function.basic_auth.version}"
}

output "lambda_arn" {
  value = "${aws_lambda_function.basic_auth.arn}"
}
