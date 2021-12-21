# locals {{{
locals {
  aws_services = {
    Athena         = "Amazon Athena"
    EC2            = "Amazon Elastic Compute Cloud - Compute"
    ECR            = "Amazon EC2 Container Registry (ECR)"
    ECS            = "Amazon EC2 Container Service"
    Kubernetes     = "Amazon Elastic Container Service for Kubernetes"
    EBS            = "Amazon Elastic Block Store"
    CloudFront     = "Amazon CloudFront"
    CloudTrail     = "AWS CloudTrail"
    CloudWatch     = "AmazonCloudWatch"
    Cognito        = "Amazon Cognito"
    Config         = "AWS Config"
    DynamoDB       = "Amazon DynamoDB"
    DMS            = "AWS Database Migration Service"
    ElastiCache    = "Amazon ElastiCache"
    Elasticsearch  = "Amazon Elasticsearch Service"
    ELB            = "Amazon Elastic Load Balancing"
    Gateway        = "Amazon API Gateway"
    Glue           = "AWS Glue"
    Kafka          = "Managed Streaming for Apache Kafka"
    KMS            = "AWS Key Management Service"
    Kinesis        = "Amazon Kinesis"
    Lambda         = "AWS Lambda"
    Lex            = "Amazon Lex"
    Matillion      = "Matillion ETL for Amazon Redshift"
    Pinpoint       = "AWS Pinpoint"
    Polly          = "Amazon Polly"
    Rekognition    = "Amazon Rekognition"
    RDS            = "Amazon Relational Database Service"
    Redshift       = "Amazon Redshift"
    S3             = "Amazon Simple Storage Service"
    SFTP           = "AWS Transfer for SFTP"
    Route53        = "Amazon Route 53"
    SageMaker      = "Amazon SageMaker"
    SecretsManager = "AWS Secrets Manager"
    SES            = "Amazon Simple Email Service"
    SNS            = "Amazon Simple Notification Service"
    SQS            = "Amazon Simple Queue Service"
    Tax            = "Tax"
    VPC            = "Amazon Virtual Private Cloud"
    WAF            = "AWS WAF"
    XRay           = "AWS X-Ray"
  }
}
# }}}

data "aws_caller_identity" "self" {}

resource "aws_budgets_budget" "organization" {
  name              = "${var.account_name}-${data.aws_caller_identity.self.account_id}-monthly"
  budget_type       = "COST"
  limit_amount      = "100"
  limit_unit        = "USD"
  time_period_start = "2021-11-30_00:00"
  time_unit         = "MONTHLY"
  cost_filters = {
    LinkedAccount = "${data.aws_caller_identity.self.account_id}"
  }

  cost_types {
    include_tax                = true  # 予算に税金を含めるかどうかを
    include_subscription       = true  # 予算にサブスクリプションを含めるかどうか
    include_refund             = true  # 予算に返金を含めるかどうか
    include_credit             = true  # 予算にクレジットを含めるかどうか
    include_upfront            = true  # 予算に前払い RI コストを含めるかどうか
    include_recurring          = true  # 予算に月額 RI コストなどの定期的な手数料を含めるかどうか
    include_other_subscription = true  # 予算に非 RI サブスクリプションコストを含めるかどうか
    include_support            = true  # 予算にサポートサブスクリプション料金を含めるかどうか
    include_discount           = true  # 予算に割引を含めるかどうか
    use_blended                = false # 予算にブレンドレートを使用するかどうか
    use_amortized              = false # 予算で償却率を使用するかどうか
  }

  notification {
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    comparison_operator        = "GREATER_THAN"
    subscriber_email_addresses = var.subscriber_emails
  }
}
