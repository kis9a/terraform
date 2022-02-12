data "template_file" "basic_auth" {
  template = file("${var.path_function}/main.js")
  vars     = var.basic_auth_credentials
}

data "archive_file" "basic_auth" {
  type        = "zip"
  output_path = "${var.path_function}/main.zip"

  source {
    content  = data.template_file.basic_auth.rendered
    filename = "main.js"
  }
}

resource "aws_lambda_function" "basic_auth" {
  filename         = data.archive_file.basic_auth.output_path
  source_code_hash = data.archive_file.basic_auth.output_base64sha256
  function_name    = "${var.service}-${var.env}"
  role             = var.lambda_role_arn
  handler          = "main.handler"
  runtime          = "nodejs12.x"
  description      = "Basic Authentication"
  publish          = true
}
