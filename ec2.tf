# ec2.tf



# # # # # # # # # # # Task_2 code start # # # # # # # # # #

# # Create a Bastion Host instance for secure access to private subnets
# resource "aws_instance" "bastion_host" {
#   ami           = var.ec2_ami_k3s
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.public[0].id
#   vpc_security_group_ids = [
#     aws_security_group.allow_ssh.id,
#     aws_security_group.allow_icmp.id
#   ]
#   key_name = aws_key_pair.my_key.key_name
#   tags = {
#     Name = "Bastion Host"
#   }
# }

# # Create a Dummy Host instance in Private nerwork to test connection from Bastion host
# resource "aws_instance" "dummy_host" {
#   ami           = var.ec2_ami_k3s
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.private[0].id
#   vpc_security_group_ids = [
#     aws_security_group.allow_ssh.id,
#     aws_security_group.allow_icmp.id
#   ]
#   key_name = aws_key_pair.my_key.key_name
#   tags = {
#     Name = "Dummy Host"
#   }
# }

# # # # # # # # # # # Task_2 code end # # # # # # # # # #



# # # # # # # # # # # Task_3 code start # # # # # # # # # #

# Create a Bastion Host instance for secure access to private subnets
resource "aws_instance" "bastion_host" {
  ami           = var.ec2_ami_k3s
  instance_type = var.ec2_instance_k3s
  subnet_id     = aws_subnet.public[0].id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_icmp.id,
    aws_security_group.allow_k3s.id
  ]
  key_name = aws_key_pair.my_key.key_name
  tags = {
    Name = "Bastion Node"
  }
}

# Create a K3S Control Node ec2 instance in Private nerwork
resource "aws_instance" "control_node" {
  ami           = var.ec2_ami_k3s
  instance_type = var.ec2_instance_k3s
  subnet_id     = aws_subnet.private[0].id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_icmp.id,
    aws_security_group.allow_k3s.id,
    aws_security_group.allow_http.id,
    aws_security_group.allow_https.id
  ]
  key_name = aws_key_pair.my_key.key_name
  tags = {
    Name = "K3S Control node"
  }
  # This installs k3s on the control node
  user_data = <<-EOF
    #!/bin/bash
    curl -sfL https://get.k3s.io | sh -
  EOF
}

# Create a K3S Agent Node ec2 instance in Private nerwork
resource "aws_instance" "agent_node" {
  ami           = var.ec2_ami_k3s
  instance_type = var.ec2_instance_k3s
  subnet_id     = aws_subnet.private[1].id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_icmp.id,
    aws_security_group.allow_k3s.id,
    aws_security_group.allow_http.id,
    aws_security_group.allow_https.id
  ]
  key_name = aws_key_pair.my_key.key_name
  tags = {
    Name = "K3S Agent node"
  }
  depends_on = [aws_instance.control_node]
}

# # Create a K3S Worker Node ec2 instance in Private nerwork
# resource "aws_instance" "worker_node" {
#   ami           = var.ec2_ami_k3s
#   instance_type = var.ec2_instance_k3s
#   subnet_id     = aws_subnet.private[1].id
#   vpc_security_group_ids = [
#     aws_security_group.allow_ssh.id,
#     aws_security_group.allow_icmp.id
#   ]
#   key_name = aws_key_pair.my_key.key_name
#   tags = {
#     Name = "K3S Worker node"
#   }
#   # Install k3s as a worker and join it to the control node
#   user_data = <<-EOF
#     #!/bin/bash
#     K3S_URL=https://${aws_instance.control_node.private_ip}:6443
#     K3S_TOKEN=$(ssh -i /path/to/your/key.pem ec2-user@${aws_instance.control_node.private_ip} "sudo cat /var/lib/rancher/k3s/server/node-token")
#     curl -sfL https://get.k3s.io | K3S_URL=$K3S_URL K3S_TOKEN=$K3S_TOKEN sh -
#   EOF
#   depends_on = [aws_instance.control_node]
# }

# # # # # # # # # # # Task_3 code end # # # # # # # # # #