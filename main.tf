# Website hosting bucket
resource "aws_s3_bucket" "website" {
  bucket = "aws-project-website-code-bucket"
}

# Enable static website hosting
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }
}

# Allow public read access
resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.website.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.website.arn}/*"
      }
    ]
  })
}