# trivy:ignore:aws-0089 # trivy:ignore:aws-0090 # trivy:ignore:aws-0132
resource "aws_s3_bucket" "data_lakehouse" {
  bucket = var.bucket_name

  tags = {
    Project     = "ETL Serverless SRE"
    Environment = "Prod"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "data_lakehouse_access" {
  bucket = aws_s3_bucket.data_lakehouse.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "bronze_layer" {
  bucket = aws_s3_bucket.data_lakehouse.id
  key    = "bronze/"
}

resource "aws_s3_object" "silver_layer" {
  bucket = aws_s3_bucket.data_lakehouse.id
  key    = "silver/"
}

resource "aws_s3_object" "gold_layer" {
  bucket = aws_s3_bucket.data_lakehouse.id
  key    = "gold/"
}
