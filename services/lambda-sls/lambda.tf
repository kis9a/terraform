data "aws_kms_secrets" "secrets" {
  secret {
    name    = "secrets"
    payload = file("${path.module}/secrets.yaml.encrypted")
  }
}

locals {
  s = yamldecode(data.aws_kms_secrets.secrets.plaintext["secrets"])
}

resource "aws_lambda_function" "this" {
  function_name = var.service
  role          = aws_iam_role.this.arn
  package_type  = "Image"
  image_uri     = "${aws_ecr_repository.this.repository_url}@${data.aws_ecr_image.this.id}"
  timeout       = 300
  depends_on    = [aws_ecr_repository.this]

  environment {
    variables = {
      ENV            = "prod"
      ENDPOINT       = "lambda"
      S3_TODO_BUCKET = aws_s3_bucket.images.id
      DB_TODO_TABLE  = aws_dynamodb_table.this.id
      DB_REMO_TABLE  = aws_dynamodb_table.remo.id
      REMO_API_TOKEN = local.s.remo_api_token
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

resource "aws_lambda_permission" "remo" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*/*"
}
