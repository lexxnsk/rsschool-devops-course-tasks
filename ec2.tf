# ec2.tf



# # # # # # # # # # # Task_2 code start # # # # # # # # # #

# Create a Bastion Host instance for secure access to private subnets
resource "aws_instance" "bastion_host" {
  ami           = var.ec2_ami_amazon_linux
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public[0].id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_icmp.id
  ]
  key_name = aws_key_pair.my_key.key_name
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
  key_name = aws_key_pair.my_key.key_name
  tags = {
    Name = "Dummy Host"
  }
}

# # # # # # # # # # # Task_2 code end # # # # # # # # # #
