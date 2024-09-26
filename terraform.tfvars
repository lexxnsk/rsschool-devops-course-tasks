# terraform.tfvars

aws_region                                        = "eu-central-1"                                                                  # AWS region for resource deployment
aws_account_id                                    = "864899869895"                                                                  # AWS Account ID
terraform_state_s3_bucket_name                    = "amyslivets.terraform-state-s3-bucket"                                          # Name of the S3 bucket for storing Terraform state
terraform_state_lock_table_name                   = "amyslivets.terraform-state-lock-table"                                         # Name of the DynamoDB table for storing Terraform locking state
terraform_environment                             = "dev"                                                                           # Environment (e.g., dev, prod)
terraform_github_actions_role_name                = "GithubActionsRole"                                                             # IAM role used by GitHub Actions
terraform_github_actions_IODC_provider_name       = "GitHub Actions OIDC Provider"                                                  # Name of the GitHub Actions IODC provider
terraform_dynamodb_access_policy_name             = "DynamoDBTerraformServiceRolePolicy"                                            # Name of the custom DynamoDB access policy 
terraform_dynamodb_access_policy_name_description = "Custom Service Role policy for Terraform to access DynamoDB for state locking" # Description of the custom DynamoDB access policy 
