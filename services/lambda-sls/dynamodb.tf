resource "aws_dynamodb_table" "this" {
  name           = "lambda-sls-todo"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
}

resource "aws_lambda_event_source_mapping" "this" {
  function_name     = aws_lambda_function.this.arn
  event_source_arn  = aws_dynamodb_table.this.stream_arn
  batch_size        = 100
  enabled           = true
  starting_position = "TRIM_HORIZON"
  depends_on        = [aws_dynamodb_table.this, aws_iam_policy.dynamodb]
}

resource "aws_dynamodb_table" "remo" {
  name           = "lambda-sls-remo"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "id"
  range_key      = "unixtime"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "unixtime"
    type = "N"
  }

  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
}

resource "aws_lambda_event_source_mapping" "remo" {
  function_name     = aws_lambda_function.this.arn
  event_source_arn  = aws_dynamodb_table.remo.stream_arn
  batch_size        = 100
  enabled           = true
  starting_position = "TRIM_HORIZON"
  depends_on        = [aws_dynamodb_table.remo, aws_iam_policy.dynamodb]
}
