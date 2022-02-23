resource "aws_lambda_function" "this" {
  function_name = var.service
  role          = aws_iam_role.this.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.this.repository_url}@${data.aws_ecr_image.this.id}"
  timeout       = 300
  depends_on    = [aws_ecr_repository.this]

  environment {
    variables = {
      ENDPOINT         = "lambda"
      AWS_S3_BUCKET    = "kis9a-lambda-sls"
      ENV              = "prod"
      SERVER_PORT      = "80"
      HTTP_AUTH_KEY    = ""
      HTTP_AUTH_SECRET = ""
      DB_ENDPOINT      = ""
      DB_DISABLE_SSL   = ""
    }
  }
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*/*"
}
