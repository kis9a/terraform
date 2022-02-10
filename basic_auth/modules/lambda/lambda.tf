data "template_file" "basic_auth" {
  template = file("${path.module}/functions/basic-auth.js")
  vars     = var.basic_auth_credentials
}

data "archive_file" "basic_auth" {
  type        = "zip"
  output_path = "${path.module}/functions/basic-auth.zip"

  source {
    content  = data.template_file.basic_auth.rendered
    filename = "basic-auth.js"
  }
}

resource "aws_lambda_function" "basic_auth" {
  filename         = "${path.module}/functions/basic-auth.zip"
  function_name    = "${var.service}-${var.env}"
  role             = var.lambda_role_arn
  handler          = "basic-auth.handler"
  source_code_hash = data.archive_file.basic_auth.output_base64sha256
  runtime          = "nodejs12.x"
  description      = "Basic Authentication"
  publish          = true
}
