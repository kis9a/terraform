resource "aws_iam_role" "ssm_role" {
  name = "${var.service}-ec2-ssm-role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "ec2.amazonaws.com",
        },
        Action : "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Name = "${var.service}-ec2-ssm-role"
  }
}

resource "aws_iam_role" "chatbot" {
  name = "chatbot-notification-role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "chatbot.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })
}
