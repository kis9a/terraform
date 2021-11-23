resource "aws_iam_role_policy" "chatbot" {
  name = "chatbot-notification-policy"
  role = aws_iam_role.chatbot.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Action : [
          "cloudwatch:Describe*",
          "cloudwatch:Get*",
          "cloudwatch:List*"
        ],
        Effect : "Allow",
        Resource : "*"
      }
    ]
  })
}
