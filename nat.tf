# nat.tf



# # # # # # # # # # # Task_2 code start # # # # # # # # # #

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "Elastic IP for the NAT Gateway"
  }
}

# Create a NAT Gateway for secure access from private subnets to the internet
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = "NAT Gateway"
  }
}

# Add a route in the private route table to direct traffic to the NAT Gateway
resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.nat_gateway.id
}

# # # # # # # # # # # Task_2 code end # # # # # # # # # #
