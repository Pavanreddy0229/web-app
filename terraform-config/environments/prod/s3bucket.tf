resource "aws_s3_bucket" "pfp-s3" {
  bucket = "pfp-s3bucket"
  acl    = "private"
  lifecycle {
    prevent_destroy  = false
  }

  versioning {
    enabled = true
  }

  tags = {
    Name        = "pfp-s3bucket"
    description = "to store terraform state file"
    Environment = "Dev"
  }
}


