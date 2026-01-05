
provider "aws" {
  region = "us-east-1"
}

# Create the S3 bucket
resource "aws_s3_bucket" "mys333bucket123" {
  bucket = "mys333bucket123"  # must be globally unique

  tags = {
    Name        = "mys333bucket123"
   
  }
}

# Enable versioning for the bucket
resource "aws_s3_bucket_versioning" "mys333bucket123" {
  bucket = aws_s3_bucket.mys333bucket123.id 

  versioning_configuration {
    status = "Enabled"
  }

}
   
  
