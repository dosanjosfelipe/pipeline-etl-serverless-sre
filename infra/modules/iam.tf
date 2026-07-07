data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# S3 BRONZE -> SILVER
resource "aws_iam_role" "lambda_processing_role_bronze_to_silver" {
  name               = "etl-serverless-sre-processing-role-bronze-to-silver"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  tags = {
    Project     = "ETL Serverless SRE"
    Environment = "Prod"
    ManagedBy   = "Terraform"
  }
}

data "aws_iam_policy_document" "lambda_s3_bronze_to_silver_access" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.bucket_name}"]
  }

  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/bronze/*"]
  }

  statement {
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/silver/*"]
  }
}

resource "aws_iam_policy" "lambda_s3_policy_bronze_to_silver" {
  name        = "etl-serverless-sre-s3-restricted-policy-bronze-to-silver"
  description = "Restricted read access to the Bronze layer and write access to the Silver layer for the ETL."
  policy      = data.aws_iam_policy_document.lambda_s3_bronze_to_silver_access.json
}

resource "aws_iam_role_policy_attachment" "attach_s3_to_lambda_bronze_to_silver" {
  role       = aws_iam_role.lambda_processing_role_bronze_to_silver.name
  policy_arn = aws_iam_policy.lambda_s3_policy_bronze_to_silver.arn
}

# CloudWatch
data "aws_iam_policy_document" "lambda_cloudwatch_logging" {
  statement {
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*"]
  }
}

resource "aws_iam_policy" "lambda_cloudwatch_policy" {
  name        = "etl-serverless-sre-cloudwatch-restricted-policy"
  description = "Allows creating logs and puting log events for the ETL."
  policy      = data.aws_iam_policy_document.lambda_cloudwatch_logging.json
}

resource "aws_iam_role_policy_attachment" "attach_cloudwatch_to_lambda_bronze_to_silver" {
  role       = aws_iam_role.lambda_processing_role_bronze_to_silver.name
  policy_arn = aws_iam_policy.lambda_cloudwatch_policy.arn
}

# S3 SILVER -> GOLD
resource "aws_iam_role" "lambda_processing_role_silver_to_gold" {
  name               = "etl-serverless-sre-processing-role-silver-to-gold"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json

  tags = {
    Project     = "ETL Serverless SRE"
    Environment = "Prod"
    ManagedBy   = "Terraform"
  }
}

data "aws_iam_policy_document" "lambda_s3_silver_to_gold_access" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = ["arn:aws:s3:::${var.bucket_name}"]
  }

  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/silver/*"]
  }

  statement {
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/gold/*"]
  }
}

resource "aws_iam_policy" "lambda_s3_policy_silver_to_gold" {
  name        = "etl-serverless-sre-s3-restricted-policy-silver-to-gold"
  description = "Restricted read access to the Silver layer and write access to the Gold layer for the ETL."
  policy      = data.aws_iam_policy_document.lambda_s3_silver_to_gold_access.json
}

resource "aws_iam_role_policy_attachment" "attach_s3_to_lambda_silver_to_gold" {
  role       = aws_iam_role.lambda_processing_role_silver_to_gold.name
  policy_arn = aws_iam_policy.lambda_s3_policy_silver_to_gold.arn
}

resource "aws_iam_role_policy_attachment" "attach_cloudwatch_to_lambda_silver_to_gold" {
  role       = aws_iam_role.lambda_processing_role_silver_to_gold.name
  policy_arn = aws_iam_policy.lambda_cloudwatch_policy.arn
}
