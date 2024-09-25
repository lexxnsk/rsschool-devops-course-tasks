# terraform.tfvars

aws_region = "eu-central-1"                                                   # AWS region for resource deployment
terraform_state_s3_bucket_name = "amyslivets.terraform-state-s3-bucket"       # Name of the S3 bucket for storing Terraform state
terraform_state_lock_table_name = "amyslivets.terraform-state-lock-table"     # Name of the DynamoDB table for storing Terraform locking state
terraform_environment = "dev"                                                 # Environment (e.g., dev, prod)
terraform_github_actions_role_name = "GithubActionsRole"                      # IAM role used by GitHub Actions
terraform_github_actions_IODC_provider_name = "GitHub Actions OIDC Provider"  # Name of the GitHub Actions IODC provider