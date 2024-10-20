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


# output "bastion_host_public_ip" {
#   value = aws_instance.bastion_host.public_ip
# }

# output "bastion_host_private_ip" {
#   value = aws_instance.bastion_host.private_ip
# }

# output "dummy_host_public_ip" {
#   value = aws_instance.dummy_host.public_ip
# }

# output "dummy_host_private_ip" {
#   value = aws_instance.dummy_host.private_ip
# }

# output "private_key" {
#   value     = tls_private_key.my_key.private_key_pem
#   sensitive = true
# }

# output "public_key" {
#   value     = aws_key_pair.my_key.public_key
#   sensitive = true
# }

output "private_key_file" {
  value     = var.private_key_file
}

# # # # # # # # # # Task_2 code end # # # # # # # # # #



# # # # # # # # # # Task_3 code start # # # # # # # # # #

output "bastion_host_public_ip" {
  value = aws_instance.bastion_host.public_ip
}

output "bastion_host_private_ip" {
  value = aws_instance.bastion_host.private_ip
}

output "control_node_public_ip" {
  value = aws_instance.control_node.public_ip
}

output "control_node_private_ip" {
  value = aws_instance.control_node.private_ip
}

output "agent_node_private_ip" {
  value = aws_instance.agent_node.private_ip
}

# # # # # # # # # # Task_3 code end # # # # # # # # # #
