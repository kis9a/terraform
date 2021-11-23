resource "aws_sns_topic" "billing" {
  name = "${var.service}-billing"
}
