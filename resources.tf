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
  name         = var.terraform_state_lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
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

# Create VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Main VPC"
  }
}

# Create Public Subnets
resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_Subnet_${count.index + 1}"
  }
}

# Create Private Subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(var.availability_zones, count.index)
  tags = {
    Name = "Private_Subnet_${count.index + 1}"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "Internet Gateway"
  }
}

# Create Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
    tags = {
    Name = "Public Route Table"
  }
}

# Create Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
  tags = {
    Name = "Private Route Table"
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public_association" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private_association" {
  count          = length(var.private_subnets)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# Create a Public Network ACL
resource "aws_network_acl" "public_acl" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "Public Network ACL"
  }
}

# Create Inbound Rule for ICMP traffic for the Public Network ACL
resource "aws_network_acl_rule" "inbound_rule_icmp" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number     = 101
  egress          = false
  protocol        = "icmp"
  rule_action     = "allow"
  cidr_block      = "0.0.0.0/0"
  icmp_type       = -1
  icmp_code       = -1
}

# Create Inbound Rule for SSH traffic for the Public Network ACL
resource "aws_network_acl_rule" "inbound_rule_ssh" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number     = 102
  egress          = false
  protocol        = "tcp"
  rule_action     = "allow"
  cidr_block      = "0.0.0.0/0"
  from_port       = 22
  to_port         = 22
}

# Create Inbound Rule for ephemeral ports for the Public Network ACL
# https://alliescomputing.com/knowledge-base/how-to-handle-ephemeral-ports
resource "aws_network_acl_rule" "inbound_rule_ephemeral" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number     = 103
  egress          = false
  protocol        = "tcp"
  rule_action     = "allow"
  cidr_block      = "0.0.0.0/0"
  from_port       = 1024
  to_port         = 65535
}

# Create Outbound Rule for the Public Network ACL
resource "aws_network_acl_rule" "outbound_rule" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number     = 100
  egress          = true
  protocol        = "all"
  rule_action     = "allow"
  cidr_block      = "0.0.0.0/0"
  from_port       = 0
  to_port         = 0
}

# Associate Public Network ACL with public subnets
resource "aws_network_acl_association" "public_nacl_associasion" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  network_acl_id = aws_network_acl.public_acl.id
}

# Create security group allowing SSH traffic
resource "aws_security_group" "allow_ssh" {
  vpc_id     = aws_vpc.main_vpc.id
  name        = "allow_ssh"
  description = "Security group allowing SSH traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_source_ip
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Allow SSH"
  }
}

# Create security group allowing ICMP traffic
resource "aws_security_group" "allow_icmp" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "allow_icmp"
  description = "Security group allowing ICMP (ping) traffic"
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.ssh_source_ip
  }
  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Allow ICMP"
  }
}

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

# Create a Bastion Host instance for secure access to private subnets
resource "aws_instance" "bastion_host" {
  ami           = var.ec2_ami_amazon_linux
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public[0].id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_icmp.id
  ]
  key_name      = aws_key_pair.my_key.key_name
  tags = {
    Name = "Bastion Host"
  }
}

# Create a Dummy Host instance in Private nerwork to test connection from Bastion host
resource "aws_instance" "dummy_host" {
  ami           = var.ec2_ami_amazon_linux
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.private[0].id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_icmp.id
  ]
  key_name      = aws_key_pair.my_key.key_name
  tags = {
    Name = "Dummy Host"
  }
}

# # Create an Elastic IP for the NAT Gateway
# resource "aws_eip" "nat" {
#   domain = "vpc"
#   tags = {
#     Name = "Elastic IP for the NAT Gateway"
#   }
# }

# # Create a NAT Gateway for secure access from private subnets to the internet
# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat.id
#   subnet_id     = aws_subnet.public[0].id
#   tags = {
#     Name = "NAT Gateway"
#   }
# }

# # Create a route in the private route table to direct traffic to the NAT Gateway
# resource "aws_route" "private_route" {
#   route_table_id         = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.nat.id
# }

# # # # # # # # # # # Task_2 code end # # # # # # # # # #
