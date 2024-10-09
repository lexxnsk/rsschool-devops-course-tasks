# outputs.tf

# # # # # # # # # # Task_1 code start # # # # # # # # # #

output "aws_region" {
  value = var.aws_region
}

# Uncomment it if you need to debug TerraForm Backend

# output "terraform_state_s3_bucket_name" {
#   value = aws_s3_bucket.terraform_state_s3_bucket.bucket
# }

# output "terraform_state_lock_table_name" {
#   value = aws_dynamodb_table.terraform_state_lock_table.id
# }

# output "terraform_github_actions_role" {
#   value = aws_iam_role.terraform_github_actions_role.arn
# }

# # # # # # # # # # Task_1 code end # # # # # # # # # #



# # # # # # # # # # Task_2 code start # # # # # # # # # #


output "bastion_host_public_ip" {
  value = aws_instance.bastion_host.public_ip
}

output "bastion_host_private_ip" {
  value = aws_instance.bastion_host.private_ip
}

output "dummy_host_public_ip" {
  value = aws_instance.dummy_host.public_ip
}

output "dummy_host_private_ip" {
  value = aws_instance.dummy_host.private_ip
}

output "private_keyyyyyy" {
  value     = tls_private_key.my_key.private_key_pem
  sensitive = true
}

# # # # # # # # # # # Task_2 code end # # # # # # # # # #
