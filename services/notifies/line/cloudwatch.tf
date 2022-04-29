resource "aws_cloudwatch_event_rule" "this" {
  name                = "${var.service}-event-rule"
  schedule_expression = var.schedule_expression
  tags                = var.service_tags
}

resource "aws_cloudwatch_event_target" "this" {
  arn  = aws_lambda_function.this.arn
  rule = aws_cloudwatch_event_rule.this.name
}

resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = aws_lambda_function.this.function_name
  source_arn    = aws_cloudwatch_event_rule.this.arn
}

resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/lambda/${var.service}"
  tags = var.service_tags
}
