resource "aws_s3_bucket" "pfp-s3" {
  bucket = "pfp-s3bucket-prod"
  acl    = "private"
  lifecycle {
    prevent_destroy  = false
  }

  versioning {
    enabled = true
  }

  tags = {
    Name        = "pfp-s3bucket-prod"
    description = "to store terraform state file"
    Environment = "prod"
  }
}


