# resources.tf

# Create S3 bucket to store Terraform state
resource "aws_s3_bucket" "terraform_state_s3_bucket" {
  bucket = var.terraform_state_s3_bucket_name
  force_destroy = true

  tags = {
    Name        = var.terraform_state_s3_bucket_name
    Environment = var.terraform_environment
  }
}

# Enable versioning for Terraform state S3 bucket
resource "aws_s3_bucket_versioning" "terraform_state_s3_bucket" {
  bucket = var.terraform_state_s3_bucket_name
  versioning_configuration {
    status = "Enabled"
  }
}

# Create DynamoDB table to store Terraform state locking
resource "aws_dynamodb_table" "terraform_state_lock_table" {
  name         = var.terraform_state_lock_table_name
  billing_mode = "PAY_PER_REQUEST" # Change this to "PROVISIONED" if needed
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = var.terraform_state_lock_table_name
    Environment = var.terraform_environment
  }
}
