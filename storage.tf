data "aws_caller_identity" "current" {}

resource "aws_ecr_repository" "vaultpay" {
  name         = lower(var.project_name)
  force_delete = var.ecr_force_delete


  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name    = "${lower(var.project_name)}-ecr"
    Project = var.project_name
  }

}
resource "aws_s3_bucket" "uploads" {
  bucket        = "${data.aws_caller_identity.current.account_id}-${lower(var.project_name)}-uploads"
  force_destroy = var.s3_force_destroy

  tags = {
    Name    = "${lower(var.project_name)}-uploads"
    Project = var.project_name
  }
}

resource "aws_s3_bucket_public_access_block" "uploads" {
  bucket = aws_s3_bucket.uploads.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}