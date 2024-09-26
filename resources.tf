# resources.tf

# S3 bucket for storing Terraform state
resource "aws_s3_bucket" "terraform_state_s3_bucket" {
  bucket        = var.terraform_state_s3_bucket_name
  force_destroy = true

  tags = {
    Name        = var.terraform_state_s3_bucket_name
    Environment = var.terraform_environment
  }
}

# S3 bucket versioning enable
resource "aws_s3_bucket_versioning" "terraform_state_s3_bucket" {
  bucket = var.terraform_state_s3_bucket_name
  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB table for storing Terraform locking state
resource "aws_dynamodb_table" "terraform_state_lock_table" {
  name         = var.terraform_state_lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = var.terraform_state_lock_table_name
    Environment = var.terraform_environment
  }
}

# IAM Role for GitHub Actions
resource "aws_iam_role" "terraform_github_actions_role" {
  name               = var.terraform_github_actions_role_name
  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role_policy.json

  tags = {
    Name        = var.terraform_github_actions_role_name
    Environment = var.terraform_environment
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
      # values   = ["repo:lexxnsk/rsschool-devops-course-tasks:ref:refs/heads/dev*"] # Uncomment it to make condition more strict
    }
  }
}

# Attach Policies to the IAM role
resource "aws_iam_role_policy_attachment" "ec2_full_access" {
  role       = aws_iam_role.terraform_github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "route53_full_access" {
  role       = aws_iam_role.terraform_github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

resource "aws_iam_role_policy_attachment" "s3_full_access" {
  role       = aws_iam_role.terraform_github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "iam_full_access" {
  role       = aws_iam_role.terraform_github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_iam_role_policy_attachment" "vpc_full_access" {
  role       = aws_iam_role.terraform_github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_role_policy_attachment" "sqs_full_access" {
  role       = aws_iam_role.terraform_github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

resource "aws_iam_role_policy_attachment" "eventbridge_full_access" {
  role       = aws_iam_role.terraform_github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
}

# resource "aws_iam_role_policy_attachment" "AmazonDynamoDBFullAccess" {
#   role       = aws_iam_role.terraform_github_actions_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
# }

resource "aws_iam_policy" "terraform_dynamodb_access" {
  name        = "TerraformDynamoDBAccess"
  description = "Custom policy for Terraform to access DynamoDB for state locking"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:DeleteItem"
        ]
        Resource  = "arn:aws:dynamodb:eu-central-1:864899869895:table/${var.terraform_state_lock_table_name}"
      },
    ]
  })
}

# Attach Policies to the IAM role
resource "aws_iam_role_policy_attachment" "terraform_dynamodb_access" {
  role       = aws_iam_role.terraform_github_actions_role.name
  policy_arn = aws_iam_policy.terraform_dynamodb_access.arn
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
}