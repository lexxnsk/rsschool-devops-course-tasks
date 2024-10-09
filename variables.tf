# variables.tf

# # # # # # # # # # Task_1 code start # # # # # # # # # #

variable "aws_region" {
  description = "Default AWS region for resource deployment"
  type        = string
  default     = "eu-central-1"
}

variable "aws_account_id" {
  description = "AWS Account ID. It is stored in GitHub Secrets and taken later from environmental variables"
  type        = string
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

variable "required_iam_policies" {
  description = "The List of Required IAM Policies"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
  ]
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

variable "terraform_dynamodb_access_allowed_actions" {
  description = "The List of allowed actions for Terraform in the custom DynamoDB access policy"
  type        = list(string)
  default = [
    "dynamodb:PutItem",
    "dynamodb:GetItem",
    "dynamodb:DeleteItem",
    "dynamodb:DescribeTable",
    "dynamodb:DescribeContinuousBackups",
    "dynamodb:DescribeTimeToLive",
    "dynamodb:ListTagsOfResource"
  ]
}

# # # # # # # # # # Task_1 code end # # # # # # # # # #




# # # # # # # # # # Task_2 code start # # # # # # # # # #

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/22"
}

variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "availability_zones" {
  description = "Availability zones"
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "ssh_source_ip" {
  description = "IP address of the device allowed to connect to the Bastion Host"
  default     = ["0.0.0.0/0"] # Replace with your IP 
}

variable "ec2_ami_amazon_linux" {
  description = "Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type 64-bit (x86)"
  default     = "ami-0e6a13e7a5b66ff4d"
}

# # # # # # # # # # Task_2 code end # # # # # # # # # #
