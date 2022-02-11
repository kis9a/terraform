resource "aws_cloudwatch_event_rule" "this" {
  name                = "${var.service}-event-rule"
  schedule_expression = var.schedule_expression
  tags                = var.service_tags
}

resource "aws_cloudwatch_event_target" "this" {
  arn  = var.lambda_function_arn
  rule = aws_cloudwatch_event_rule.this.name
}

resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/lambda/${var.service}"
  tags = var.service_tags
}
