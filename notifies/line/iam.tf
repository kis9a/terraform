resource "aws_iam_role" "this" {
  name               = "${var.service}-role"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_policy" "cloudwatch" {
  name   = "${var.service}-cloudwatch"
  policy = data.aws_iam_policy_document.cloudwatch.json
}

resource "aws_iam_policy" "billing" {
  name   = "${var.service}-billing"
  policy = data.aws_iam_policy_document.billing.json
}


resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.cloudwatch.arn
}

resource "aws_iam_role_policy_attachment" "billing" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.billing.arn
}

data "aws_iam_policy_document" "this" {
  statement {
    sid     = "AssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "cloudwatch" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "billing" {
  statement {
    effect = "Allow"
    actions = [
      "ce:GetCostAndUsage"
    ]
    resources = [
      "*",
    ]
  }
}
