resource "aws_s3_bucket" "zamans3terra" {
  bucket = "zamans3terraform"
  acl = "public-read-write"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}