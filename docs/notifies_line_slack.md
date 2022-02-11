## about

notify aws cost of monthly and daily to line and slack
infrastructure: cloudwatch events trigger -> sns -> lambda -> line, slack

## build function

```
cd function
GOOS=linux go build -o main
```

## first apply

```
terraform apply --target=aws_kms_alias.this --target=aws_kms_key.this
```

## encrypt credentials

```
## example decrypt
kms_decrypt secrets.yaml.encrypted kis9a > secrets.yaml

# edit secrets.yaml
## slack_webhook_url is optional

line_token: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
slack_webhook_url: https://hooks.slack.com/services/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


## example encrypt
kms_encrypt aws-cost-line-notify secrets.yaml kis9a > secrets.yaml.encrypted
```

[kms_encrypt_decrypt](../../docs/kms_encrypt_decrypt.md)

GET line_token by: <https://notify-bot.line.me/en/>

## apply

```
# edit backend.tf, variables.tf
terraform init
terraform apply
```

## cron syntax

[Schedule Expressions for Rules - Amazon CloudWatch Events Schedule Expressions for Rules - Amazon CloudWatch Events](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html)

default: cron(0 15 \* _ ? _)
