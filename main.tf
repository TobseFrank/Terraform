provider "aws" {
  region = "eu-central-1"
}

variable "website_bucket_name" {
  type = string
}

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

output "website_url" {
  value = "http://${aws_s3_bucket.website_bucket.bucket}.s3-website.${data.aws_region.region.name}.amazonaws.com"
}

resource "aws_s3_bucket_object" "index_upload" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"

  source = "index.html"

  content_type = "text/html"
}