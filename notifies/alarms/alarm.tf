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

# resource "aws_cloudwatch_metric_alarm" "api_ecsfargate_cpu_high" {
#   alarm_name          = "${aws_ecs_cluster.service_api.name}-cpu-utilization-high"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/ECS"
#   period              = "60"
#   statistic           = "Average"
#   threshold           = "85"
#   alarm_actions       = [var.alarm_sns_topic_arn]
#   dimensions = {
#     ClusterName = aws_ecs_cluster.service_api.name
#     ServiceName = aws_ecs_service.service_api.name
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "api_ecsfargate_cpu_low" {
#   alarm_name          = "${aws_ecs_cluster.service_api.name}-cpu-utilization-high"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/ECS"
#   period              = "60"
#   statistic           = "Average"
#   threshold           = "10"
#   alarm_actions       = [var.alarm_sns_topic_arn]
#   dimensions = {
#     ClusterName = aws_ecs_cluster.service_api.name
#     ServiceName = aws_ecs_service.service_api.name
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "service_ecsfargate_cpu_high" {
#   alarm_name          = "${aws_ecs_cluster.service_service.name}-cpu-utilization-high"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/ECS"
#   period              = "60"
#   statistic           = "Average"
#   threshold           = "85"
#   alarm_actions       = [var.alarm_sns_topic_arn]
#   dimensions = {
#     ClusterName = aws_ecs_cluster.service_service.name
#     ServiceName = aws_ecs_service.service_service.name
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "service_ecsfargate_cpu_low" {
#   alarm_name          = "${aws_ecs_cluster.service_service.name}-cpu-utilization-high"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/ECS"
#   period              = "60"
#   statistic           = "Average"
#   threshold           = "10"
#   alarm_actions       = [var.alarm_sns_topic_arn]
#   dimensions = {
#     ClusterName = aws_ecs_cluster.service_service.name
#     ServiceName = aws_ecs_service.service_service.name
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "aurora_rds_cpu_high" {
#   alarm_name          = "${aws_rds_cluster_instance.cluster_instances[0].id}-cpu-utilization-high"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   statistic           = "Average"
#   period              = "60"
#   namespace           = "AWS/RDS"
#   threshold           = "85"
#   alarm_actions       = [var.alarm_sns_topic_arn]
#   dimensions = {
#     DBInstanceIdentifier = aws_rds_cluster_instance.cluster_instances[0].id
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "aurora_rds_cpu_low" {
#   alarm_name          = "${aws_rds_cluster_instance.cluster_instances[0].id}-cpu-utilization-low"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   statistic           = "Average"
#   period              = "60"
#   namespace           = "AWS/RDS"
#   threshold           = "10"
#   alarm_actions       = [var.alarm_sns_topic_arn]
#   dimensions = {
#     DBInstanceIdentifier = aws_rds_cluster_instance.cluster_instances[0].id
#   }
# }
