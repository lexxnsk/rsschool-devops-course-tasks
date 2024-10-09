# igw.tf



# # # # # # # # # # # Task_2 code start # # # # # # # # # #

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "Internet Gateway"
  }
}

# # # # # # # # # # # Task_2 code end # # # # # # # # # #
