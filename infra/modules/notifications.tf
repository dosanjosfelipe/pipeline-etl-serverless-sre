# trivy:ignore:aws-0095
resource "aws_sns_topic" "pipeline_notification" {
  name = var.notification_name

  tags = {
    Project     = "ETL Serverless SRE"
    Environment = "Prod"
    ManagedBy   = "Terraform"
  }
}

resource "aws_sqs_queue" "pipeline_queue" {
  name                    = var.queue_name
  sqs_managed_sse_enabled = true

  tags = {
    Project     = "ETL Serverless SRE"
    Environment = "Prod"
    ManagedBy   = "Terraform"
  }
}
