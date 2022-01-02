resource "aws_iam_policy" "mfa_required" {
  name = "mfa-required-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "iam:CreateVirtualMFADevice",
          "iam:DeleteVirtualMFADevice",
          "iam:DeactivateMFADevice",
          "iam:EnableMFADevice",
          "iam:ResyncMFADevice",
          "iam:ListMFADevices"
        ],
        Sid    = "AllowIndividualUserToManageTheirOwnMFA"
        Effect = "Allow",
        Resource = [
          "arn:aws:iam::*:mfa/*",
          "arn:aws:iam::*:user/*"
        ]
      },
      {
        Action = [
          "iam:CreateVirtualMFADevice",
          "iam:DeleteVirtualMFADevice",
          "iam:DeactivateMFADevice",
          "iam:EnableMFADevice",
          "iam:ResyncMFADevice",
          "iam:ListMFADevices"
        ],
        Sid      = "BlockMostAccessUnlessSignedInWithMFA"
        Effect   = "Deny",
        Resource = "*",
        Condition = {
          BoolIfExists = {
            "aws:MultiFactorAuthPresent" = "false"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "limitation_region_tokyo" {
  name = "only-region-tokyo-allow"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = var.region_limitation_actions,
        Resource = "*",
        Effect   = "Deny",
        Condition = {
          StringNotEquals = {
            "aws:RequestedRegion" : [
              "ap-northeast-1"
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "limitation_region_osaka" {
  name = "only-region-osaka-allow"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = var.region_limitation_actions,
        Resource = "*",
        Effect   = "Deny",
        Condition = {
          StringNotEquals = {
            "aws:RequestedRegion" : [
              "ap-northeast-3"
            ]
          }
        }
      }
    ]
  })
}

## role
resource "aws_iam_role_policy" "chatbot" {
  name = "chatbot-notification-policy"
  role = aws_iam_role.chatbot.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "cloudwatch:Describe*",
          "cloudwatch:Get*",
          "cloudwatch:List*"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}
