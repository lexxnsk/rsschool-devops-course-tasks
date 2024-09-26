# variables.tf

variable "aws_region" {
  description = "Default AWS region to deploy resources"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
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

variable "terraform_github_actions_role_name" {
  description = "IAM role for Github Actions"
  type        = string
}

variable "terraform_github_actions_IODC_provider_name" {
  description = "GitHub Actions OIDC Provider"
  type        = string
}

variable "terraform_dynamodb_access_policy_name" {
  description = "Custom Service Role policy for Terraform to access DynamoDB for state locking"
  type        = string
}

variable "terraform_dynamodb_access_policy_name_description" {
  description = "Custom Service Role policy for Terraform to access DynamoDB for state locking"
  type        = string
}