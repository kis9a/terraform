resource "aws_sns_topic" "budget" {
  name = "budget"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "budgets.amazonaws.com"
      },
      Action   = "SNS:Publish",
      Resource = "*",
      Condition = {
        ArnLike = {
          "aws:SourceArn" : "arn:aws:budgets::${data.aws_caller_identity.self.account_id}:budget/*"
        }
      }
    }]
  })
}
