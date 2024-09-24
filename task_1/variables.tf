# variables.tf

variable "aws_region" {
  description = "Default AWS region to deploy resources"
  type        = string
}

variable "terraform_state_s3_bucket_name" {
  description = "The name of the S3 bucket for Terraform state"
  type        = string
}

variable "terraform_state_lock_table_name" {
  description = "Terraform State Lock Table"
  type        = string
}

variable "terraform_environment" {
  description = "The environment (e.g., dev, prod)"
  type        = string
}

