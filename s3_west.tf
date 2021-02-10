# ensure we stay in us-west-2 our default aws region
data "aws_region" "current" {}

resource "aws_s3_bucket" "loging_setup" {
  bucket = "awslovato"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "awslovato" {
  bucket = "awslovato"
  acl    = "private"

  tags = {
    Name        = "Default bucket"
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

resource "aws_s3control_bucket_lifecycle_configuration" "expire-awslovato" {
  bucket = aws_s3_bucket.awslovato.arn

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
