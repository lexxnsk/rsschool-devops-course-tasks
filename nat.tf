# nat.tf



# # # # # # # # # # # Task_2 code start # # # # # # # # # #

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "Elastic IP for the NAT Gateway"
  }
}

# Create an Elastic IP for the Bastion Host
resource "aws_eip" "bastion_eip" {
  domain = "vpc"
  tags = {
    Name = "Elastic IP for the Bastion Host"
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
# Route is added in route_tables.tf in aws_route_table.private

# Associate an Elastic IP with the Bastion Host EC2 instance
resource "aws_eip_association" "my_eip_association" {
  instance_id = aws_instance.bastion_host.id
  allocation_id = aws_eip.bastion_eip.id
  depends_on = [
    aws_instance.bastion_host,  # Ensure the bastion host instance is created first
    aws_eip.bastion_eip         # Ensure the Elastic IP is allocated first
  ]
}

# # # # # # # # # # # Task_2 code end # # # # # # # # # #
