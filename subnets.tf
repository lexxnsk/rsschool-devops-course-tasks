# subnets.tf



# # # # # # # # # # # Task_2 code start # # # # # # # # # #

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

# # # # # # # # # # # Task_2 code end # # # # # # # # # #
