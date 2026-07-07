# trivy:ignore:aws-0017
resource "aws_cloudwatch_log_group" "lambda_log_group_bronze_silver" {
  name              = "/aws/lambda/${var.lambda_bronze_to_silver_name}"
  retention_in_days = 14

  tags = {
    Project     = "ETL Serverless SRE"
    Environment = "Prod"
    ManagedBy   = "Terraform"
  }
}

# trivy:ignore:aws-0017
resource "aws_cloudwatch_log_group" "lambda_log_group_silver_gold" {
  name              = "/aws/lambda/${var.lambda_silver_to_gold_name}"
  retention_in_days = 14

  tags = {
    Project     = "ETL Serverless SRE"
    Environment = "Prod"
    ManagedBy   = "Terraform"
  }
}
