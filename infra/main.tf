module "aws_stack" {
  source                       = "./modules"
  bucket_name                  = var.bucket_name
  notification_name            = var.notification_name
  queue_name                   = var.queue_name
  lambda_bronze_to_silver_name = var.lambda_bronze_to_silver_name
  lambda_silver_to_gold_name   = var.lambda_silver_to_gold_name
}
