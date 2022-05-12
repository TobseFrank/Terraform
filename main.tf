provider "aws" {
  region = "eu-central-1"
}

module "static_website" {
  source = "./static_website"
  index_path = "index.html"
  website_bucket_name = "asdklfjalskdjqwpoitreuj"
  css_path = "style.css"
}

output "website_url" {
  value = module.static_website.website_url
}