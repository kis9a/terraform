resource "aws_iam_user_policy_attachment" "user_frontend_s3_full_access" {
  user       = aws_iam_user.frontend.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_user_policy_attachment" "user_frontend_cloudfront_full_access" {
  user       = aws_iam_user.frontend.name
  policy_arn = "arn:aws:iam::aws:policy/CloudFrontFullAccess"
}
