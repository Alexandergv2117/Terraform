resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.bucket_name}"
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "bucket-website-configuration" {
  bucket = aws_s3_bucket.app_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket-public-access-block" {
  bucket = aws_s3_bucket.app_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "bucket-policy" {

  depends_on = [
    aws_s3_bucket_public_access_block.bucket-public-access-block,
  ]

  bucket = aws_s3_bucket.app_bucket.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "PublicReadGetObject",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "s3:GetObject"
        ],
        "Resource": [
          "${aws_s3_bucket.app_bucket.arn}",
          "${aws_s3_bucket.app_bucket.arn}/*"
        ]
      },
    ]
  })
}

output "url_s3_bucket" {
  value = "http://${aws_s3_bucket.app_bucket.bucket}.s3-website-${var.region}.amazonaws.com"
}