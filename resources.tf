# resources.tf

# # # # # # # # # # Task_1 code start # # # # # # # # # #

# S3 bucket for storing Terraform state
resource "aws_s3_bucket" "terraform_state_s3_bucket" {
  bucket        = var.terraform_state_s3_bucket_name
  force_destroy = true
  tags = {
    Name        = var.terraform_state_s3_bucket_name
    Environment = var.terraform_environment
  }
  lifecycle {
    prevent_destroy = true
  }
}

# S3 bucket versioning enable
resource "aws_s3_bucket_versioning" "terraform_state_s3_bucket" {
  bucket = var.terraform_state_s3_bucket_name
  versioning_configuration {
    status = "Enabled"
  }
  lifecycle {
    prevent_destroy = true
  }
}

# DynamoDB table for storing Terraform locking state
resource "aws_dynamodb_table" "terraform_state_lock_table" {
  name                        = var.terraform_state_lock_table_name
  billing_mode                = "PAY_PER_REQUEST"
  hash_key                    = "LockID"
  deletion_protection_enabled = true
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name        = var.terraform_state_lock_table_name
    Environment = var.terraform_environment
  }
  lifecycle {
    prevent_destroy = true
  }
}

# IAM role used by GitHub Actions
resource "aws_iam_role" "terraform_github_actions_role" {
  name               = var.terraform_github_actions_role_name
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role_policy.json
  tags = {
    Name        = var.terraform_github_actions_role_name
    Environment = var.terraform_environment
  }
  lifecycle {
    prevent_destroy = true
  }
}

data "aws_iam_policy_document" "github_actions_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions_IODC_provider.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:lexxnsk/rsschool-devops-course-tasks:*"]
      # values   = ["repo:lexxnsk/rsschool-devops-course-tasks:ref:refs/heads/dev"] # Uncomment it to make condition more strict
    }
  }
}

# Attach Required Policies to the IAM role
resource "aws_iam_role_policy_attachment" "required_iam_policies" {
  for_each   = toset(var.required_iam_policies)
  role       = aws_iam_role.terraform_github_actions_role.name
  policy_arn = each.value
  lifecycle {
    prevent_destroy = true
  }
}

# Create the custom DynamoDB access policy to let Terraform access DynamoDB table for storing Terraform locking state
resource "aws_iam_policy" "terraform_dynamodb_access_policy" {
  name        = var.terraform_dynamodb_access_policy_name
  description = var.terraform_dynamodb_access_policy_name_description
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = var.terraform_dynamodb_access_allowed_actions
        Resource = "arn:aws:dynamodb:${var.aws_region}:${var.aws_account_id}:table/${var.terraform_state_lock_table_name}"
      },
    ]
  })
  lifecycle {
    prevent_destroy = true
  }
}

# Attach the custom DynamoDB access policy to the IAM role
resource "aws_iam_role_policy_attachment" "terraform_dynamodb_access" {
  role       = aws_iam_role.terraform_github_actions_role.name
  policy_arn = aws_iam_policy.terraform_dynamodb_access_policy.arn
  lifecycle {
    prevent_destroy = true
  }
}

# GitHub Actions OIDC Provider
resource "aws_iam_openid_connect_provider" "github_actions_IODC_provider" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd"]
  tags = {
    Name        = var.terraform_github_actions_IODC_provider_name
    Environment = var.terraform_environment
  }
  lifecycle {
    prevent_destroy = true
  }
}

# # # # # # # # # # Task_1 code end # # # # # # # # # #



# # # # # # # # # # # Task_2 code start # # # # # # # # # #


# Generate a new SSH key pair pair
resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create an EC2 key pair from the generated private key
resource "aws_key_pair" "my_key" {
  key_name   = "SSH Private Key to connect to EC2 instances"
  public_key = tls_private_key.my_key.public_key_openssh
}

# In order to save private_key run these commands:
# terraform output private_key > my_key.pem
# chmod 400 my_key.pem 

# # # # # # # # # # # Task_2 code end # # # # # # # # # #