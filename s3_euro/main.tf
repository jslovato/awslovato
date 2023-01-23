# ensure we stay in us-west-2 our default aws region
data "aws_region" "current" {}

resource "aws_s3_bucket" "awslovato_euro_logging" {
  bucket = "awslovatoeuro"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "awslovatoeuro" {
  bucket = "awslovato"
  acl    = "private"

  tags = {
    Name        = "EU saving bucket"
    Environment = "All"
  }

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "logs/"
  }

  versioning {
    enabled = true
  }
}

resource "aws_s3control_bucket_lifecycle_configuration" "expire-awslovatoeuro" {
  bucket = aws_s3_bucket.awslovatoeuro.arn

  rule {
    expiration {
      days = 365
    }

    filter {
      prefix = "logs/"
    }

    id = "logscleanout"
  }
}
