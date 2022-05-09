resource "aws_s3_bucket" "website_bucket" {
  bucket = var.website_bucket_name
  acl    = "public-read"

  policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    { "Sid": "PublicRedForGetBucketObjects",
      "Effect": "Allow",
      "Principal": {
        "AWS":"*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.website_bucket_name}/*"
    }
  ]
}
EOF

  website {
    index_document = "index.html"
  }
}

data "aws_region" "region" {

}

resource "aws_s3_bucket_object" "index_upload" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"

  source = var.index_path

  content_type = "text/html"
}