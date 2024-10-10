# route_tables.tf



# # # # # # # # # # # Task_2 code start # # # # # # # # # #

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
  #   route {
  #     cidr_block     = "0.0.0.0/0"
  #     nat_gateway_id = aws_nat_gateway.nat_gateway.id
  #   }
  tags = {
    Name = "Private Route Table"
  }
}

# # # # # # # # # # # Task_2 code end # # # # # # # # # #
