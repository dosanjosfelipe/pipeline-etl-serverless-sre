data "archive_file" "python_code_transformation_bronze_to_silver" {
  type        = "zip"
  source_dir  = "${path.module}/../../../src/transformation/bronze_silver"
  output_path = "${path.module}/transformation_code.zip"
}

data "archive_file" "python_code_transformation_silver_to_gold" {
  type        = "zip"
  source_dir  = "${path.module}/../../../src/transformation/silver_gold"
  output_path = "${path.module}/transformation_code.zip"
}

# BRONZE -> SILVER
# trivy:ignore:aws-0066
resource "aws_lambda_function" "lambda_bronze_to_silver" {
  function_name = var.lambda_bronze_to_silver_name
  role          = aws_iam_role.lambda_processing_role_bronze_to_silver.arn
  handler       = "main.lambda_handler"

  filename         = data.archive_file.python_code_transformation_bronze_to_silver.output_path
  source_code_hash = data.archive_file.python_code_transformation_bronze_to_silver.output_base64sha256

  runtime     = "python3.14"
  timeout     = 300
  memory_size = 512

  environment {
    variables = {
      ENVIRONMENT   = "Prod"
      BUCKET_NAME   = aws_s3_bucket.data_lakehouse.id
      SNS_TOPIC_ARN = aws_sns_topic.pipeline_notification.arn
    }
  }

  depends_on = [aws_cloudwatch_log_group.lambda_log_group]
}

# SILVER -> GOLD
# trivy:ignore:aws-0066
resource "aws_lambda_function" "lambda_silver_to_gold" {
  function_name = var.lambda_silver_to_gold_name
  role          = aws_iam_role.lambda_processing_role_silver_to_gold.arn
  handler       = "main.lambda_handler"

  filename         = data.archive_file.python_code_transformation_silver_to_gold.output_path
  source_code_hash = data.archive_file.python_code_transformation_silver_to_gold.output_base64sha256

  runtime     = "python3.14"
  timeout     = 300
  memory_size = 512

  environment {
    variables = {
      ENVIRONMENT   = "Prod"
      BUCKET_NAME   = aws_s3_bucket.data_lakehouse.id
      SNS_TOPIC_ARN = aws_sns_topic.pipeline_notification.arn
    }
  }

  depends_on = [aws_cloudwatch_log_group.lambda_log_group]
}
