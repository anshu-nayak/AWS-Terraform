output "website_endpoint" {
  description = "S3 static website URL"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}