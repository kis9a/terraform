resource "aws_sns_topic" "billing" {
  name = "${var.service}-billing"
}

resource "aws_sns_topic" "alert" {
  name = "${var.service}-alerm-topic"
}
