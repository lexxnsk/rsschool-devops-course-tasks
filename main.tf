# main.tf

terraform {
  backend "s3" {
    bucket         = var.terraform_state_s3_bucket_name
    key            = var.terraform_tfstate_file_name
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = var.terraform_state_lock_table_name
  }
}