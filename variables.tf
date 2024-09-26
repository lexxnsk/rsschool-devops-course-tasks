# variables.tf

variable "aws_region" {
  description = "Default AWS region for resource deployment"
  type        = string
  default     = "eu-central-1"
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  default     = "864899869895"
}

variable "terraform_state_s3_bucket_name" {
  description = "The Name of the S3 bucket for storing Terraform state"
  type        = string
  default     = "amyslivets.terraform-state-s3-bucket"
}

variable "terraform_state_lock_table_name" {
  description = "The Name of the DynamoDB table for storing Terraform locking state"
  type        = string
  default     = "amyslivets.terraform-state-lock-table"
}

variable "terraform_environment" {
  description = "The environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "terraform_github_actions_role_name" {
  description = "IAM role used by GitHub Actions"
  type        = string
  default     = "GithubActionsRole"
}

variable "terraform_github_actions_IODC_provider_name" {
  description = "The Name of the GitHub Actions IODC provider"
  type        = string
  default     = "GitHub Actions OIDC Provider"
}

variable "terraform_dynamodb_access_policy_name" {
  description = "The Name of the custom DynamoDB access policy"
  type        = string
  default     = "DynamoDBTerraformServiceRolePolicy"
}

variable "terraform_dynamodb_access_policy_name_description" {
  description = "The Description of the custom DynamoDB access policy "
  type        = string
  default     = "Custom Service Role policy for Terraform to access DynamoDB for state locking"
}