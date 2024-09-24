# outputs.tf

output "aws_region" {
  value       = var.aws_region
  description = "The AWS region"
}

output "terraform_state_s3_bucket_name" {
  value = aws_s3_bucket.terraform_state_s3_bucket.bucket
}

output "terraform_state_lock_table_name" {
  value = aws_dynamodb_table.terraform_state_lock_table.id
}