resource "aws_s3_bucket" "foundry_managed" {
  bucket        = "foundry-managed-smoke-273613910635-eu-west-1"
  force_destroy = false

  tags = {
    ManagedBy = "project-foundry"
  }
}

resource "aws_s3_bucket_versioning" "foundry_managed" {
  bucket = aws_s3_bucket.foundry_managed.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "foundry_managed" {
  bucket = aws_s3_bucket.foundry_managed.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "foundry_managed" {
  bucket = aws_s3_bucket.foundry_managed.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

output "foundry_managed_s3_bucket_name" {
  value = aws_s3_bucket.foundry_managed.bucket
}
