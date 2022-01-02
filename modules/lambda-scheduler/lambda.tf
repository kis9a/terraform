resource "aws_lambda_permission" "this" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = var.lambda_function_name
  source_arn    = aws_cloudwatch_event_rule.this.arn
}

