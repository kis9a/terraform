data "archive_file" "this" {
  type        = "zip"
  source_file = "./function/main"
  output_path = "./function/main.zip"
}

resource "aws_lambda_function" "this" {
  function_name    = var.service
  handler          = "main"
  runtime          = "go1.x"
  role             = aws_iam_role.this.arn
  filename         = data.archive_file.this.output_path
  source_code_hash = data.archive_file.this.output_base64sha256
  publish          = true
  memory_size      = 128
  timeout          = 3

  environment {
    variables = {
      AWS_COST_LINE_NOTIFY_TOKEN = local.line_token
    }
  }
}
