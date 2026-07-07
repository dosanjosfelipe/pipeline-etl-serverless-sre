variable "bucket_name" {
  type        = string
  description = "Global unique name for bucket"
}

variable "notification_name" {
  type        = string
  description = "Global unique name for notification"
}

variable "queue_name" {
  type        = string
  description = "Global unique name for queue"
}

variable "lambda_bronze_to_silver_name" {
  type        = string
  description = "Global unique name for lambda bronze to silver"
}

variable "lambda_silver_to_gold_name" {
  type        = string
  description = "Global unique name for lambda silver to gold"
}
