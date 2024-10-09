# route_tables.tf



# # # # # # # # # # # Task_2 code start # # # # # # # # # #

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

# # # # # # # # # # # Task_2 code end # # # # # # # # # #
