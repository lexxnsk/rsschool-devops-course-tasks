# route_tables.tf



# # # # # # # # # # # Task_2 code start # # # # # # # # # #

# Create security group allowing SSH traffic
resource "aws_security_group" "allow_ssh" {
  vpc_id      = aws_vpc.main_vpc.id
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



# # # # # # # # # # # Task_3 code start # # # # # # # # # #

# Create security group allowing K3S traffic
resource "aws_security_group" "allow_k3s" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "allow_k3s"
  description = "Security group allowing K3S 6443 port traffic"
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = var.ssh_source_ip
  }
  egress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Allow K3S 6443 port traffic"
  }
}

# Create security group allowing WEB traffic
resource "aws_security_group" "allow_web" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "allow_web"
  description = "Security group allowing WEB traffic"
  # Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ssh_source_ip
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ssh_source_ip
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow 32xxx
  ingress {
    from_port   = 32000
    to_port     = 33000
    protocol    = "tcp"
    cidr_blocks = var.ssh_source_ip
  }
  egress {
    from_port   = 32000
    to_port     = 33000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Allow WEB traffic"
  }
}

# # Create security group allowing HTTPS traffic
# resource "aws_security_group" "allow_https" {
#   vpc_id      = aws_vpc.main_vpc.id
#   name        = "allow_https"
#   description = "Security group allowing HTTPS traffic"

#   }
#   tags = {
#     Name = "Allow HTTPS traffic"
#   }
# }

# # Create security group allowing Jenkins WEB traffic
# resource "aws_security_group" "allow_jenkins" {
#   vpc_id      = aws_vpc.main_vpc.id
#   name        = "allow_jenkins"
#   description = "Security group allowing Jenkins WEB traffic"

#   }
#   tags = {
#     Name = "Allow Jenkins WEB traffic"
#   }
# }

# # # # # # # # # # # Task_3 code end # # # # # # # # # #