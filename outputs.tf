# outputs.tf

# # # # # # # # # # Task_1 code start # # # # # # # # # #

output "aws_region" {
  value       = var.aws_region
  description = "The AWS region"
}

output "terraform_state_s3_bucket_name" {
  value = aws_s3_bucket.terraform_state_s3_bucket.bucket
}

output "terraform_state_lock_table_name" {
  value = aws_dynamodb_table.terraform_state_lock_table.id
}

output "terraform_github_actions_role" {
  value = aws_iam_role.terraform_github_actions_role.arn
}

# # # # # # # # # # Task_1 code end # # # # # # # # # #



# # # # # # # # # # Task_2 code start # # # # # # # # # #

output "main_vpc" {
  value = aws_vpc.main_vpc.id
}

# output "public_subnets" {
#   value = aws_subnet.public[*].id
# }

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.igw.id
}

# # # # # # # # # # Task_2 code end # # # # # # # # # #
