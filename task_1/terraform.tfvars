# terraform.tfvars

aws_region = "eu-central-1"                                                # Default AWS region to deploy resources
terraform_state_s3_bucket_name = "amyslivets.terraform-state-s3-bucket"    # The name of the S3 bucket for Terraform state
terraform_state_lock_table_name = "amyslivets.terraform-state-lock-table" 
terraform_environment = "dev"                                              # The environment (e.g., dev, prod)