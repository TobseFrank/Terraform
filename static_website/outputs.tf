output "website_url" {
  value = "http://${aws_s3_bucket.website_bucket.bucket}.s3-website.${data.aws_region.region.name}.amazonaws.com"
}