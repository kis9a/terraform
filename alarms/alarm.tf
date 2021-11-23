resource "aws_cloudwatch_metric_alarm" "billing" {
  count               = length(var.billing_threshold)
  alarm_name          = "${var.service}-billing ${count.index + 1} (${var.billing_threshold[count.index]} USD)"
  alarm_description   = "Total Charge ${var.billing_threshold[count.index]} USD"
  alarm_actions       = ["${aws_sns_topic.billing.arn}"]
  threshold           = var.billing_threshold[count.index]
  dimensions          = { "Currency" = "USD" }
  namespace           = "AWS/Billing"
  metric_name         = "EstimatedCharges"
  statistic           = "Maximum"
  evaluation_periods  = "1"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  period              = "21600"
}
