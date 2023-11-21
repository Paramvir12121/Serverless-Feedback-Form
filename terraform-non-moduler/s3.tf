module "s3_bucket_webpages" {
  source                    = "./modules/s3_bucket_webpages"
  aws_region                = local.aws_region
  files_to_upload           = ["feedback.html"] # Define a list of files to upload
  bucket_name               = "feedback-form-test-1.9"
  aws_credentials_file_path = var.aws_credentials_file_path
  tags                      = local.tags
}


resource "aws_s3_bucket" "bucket" {
  bucket = "feedback-form-0.0.1"
  tags   = local.tags

}

resource "aws_s3_bucket_public_access_block" "feedback" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "feedback" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_acl" "feedback" {
  depends_on = [
    aws_s3_bucket_ownership_controls.feedback,
    aws_s3_bucket_public_access_block.feedback,
  ]

  bucket = aws_s3_bucket.bucket.id
  acl    = "public-read"
}


# Create separate resource blocks for each file
resource "aws_s3_bucket_object" "object" {
  depends_on   = [aws_s3_bucket.bucket]
  for_each     = { for file in var.files_to_upload : file => file }
  bucket       = var.bucket_name
  key          = each.value
  source       = "../website/${each.value}"
  etag         = filemd5("../website/${each.value}")
  tags         = local.tags
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.bucket.id
  index_document {
    suffix = "feedback.html"
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  depends_on = [aws_s3_bucket_object.object]
  bucket     = aws_s3_bucket.bucket.id
  policy     = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.bucket.arn}/*",
    ]
  }
}

