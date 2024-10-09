# vpc.tf



# # # # # # # # # # # Task_2 code start # # # # # # # # # #

# Create VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Main VPC"
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

# Associate Public Network ACL with public subnets
resource "aws_network_acl_association" "public_nacl_associasion" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  network_acl_id = aws_network_acl.public_acl.id
}

# # # # # # # # # # # Task_2 code end # # # # # # # # # #
