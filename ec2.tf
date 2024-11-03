# ec2.tf



# # # # # # # # # # # Task_2 code start # # # # # # # # # #

# # Create a Bastion Host instance for secure access to private subnets
# resource "aws_instance" "bastion_host" {
#   ami           = var.ec2_ami_k3s
#   instance_type = var.ec2_instance_bastion
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
#   instance_type = var.ec2_instance_bastion
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

# # Create a Bastion Host instance for secure access to private subnets
# resource "aws_instance" "bastion_host" {
#   ami           = var.ec2_ami_k3s
#   instance_type = var.ec2_instance_bastion
#   subnet_id     = aws_subnet.public[0].id
#   vpc_security_group_ids = [
#     aws_security_group.allow_ssh.id,
#     aws_security_group.allow_icmp.id,
#     aws_security_group.allow_k3s.id
#   ]
#   key_name = aws_key_pair.my_key.key_name
#   tags = {
#     Name = "Bastion Node"
#   }
# }

# # Create a K3S Server Node ec2 instance in Private nerwork
# resource "aws_instance" "server_node" {
#   ami           = var.ec2_ami_k3s
#   instance_type = var.ec2_instance_k3s
#   subnet_id     = aws_subnet.private[0].id
#   vpc_security_group_ids = [
#     aws_security_group.allow_ssh.id,
#     aws_security_group.allow_icmp.id,
#     aws_security_group.allow_k3s.id,
#     aws_security_group.allow_http.id,
#     aws_security_group.allow_https.id
#   ]
#   key_name = aws_key_pair.my_key.key_name
#   tags = {
#     Name = "K3S Server node"
#   }
#   # This installs k3s server node
#   user_data = <<-EOF
#     #!/bin/bash
#     curl -sfL https://get.k3s.io/ | INSTALL_K3S_EXEC="server" sh -s - --token ${var.k3s_token}
#   EOF
# }

# # Create a K3S Agent Node ec2 instance in Private nerwork
# resource "aws_instance" "agent_node_1" {
#   ami           = var.ec2_ami_k3s
#   instance_type = var.ec2_instance_k3s
#   subnet_id     = aws_subnet.private[1].id
#   vpc_security_group_ids = [
#     aws_security_group.allow_ssh.id,
#     aws_security_group.allow_icmp.id,
#     aws_security_group.allow_k3s.id,
#     aws_security_group.allow_http.id,
#     aws_security_group.allow_https.id
#   ]
#   key_name = aws_key_pair.my_key.key_name
#   tags = {
#     Name = "K3S Agent node 1 - test"
#   }
#   # This installs k3s agent node and joins it to a server node
#   user_data = <<-EOF
#     #!/bin/bash
#     curl -sfL https://get.k3s.io/ | INSTALL_K3S_EXEC="agent" K3S_URL=https://${aws_instance.server_node.private_ip}:6443/ K3S_TOKEN=${var.k3s_token} sh -s -
#   EOF
#   depends_on = [aws_instance.server_node]
# }

# # # # # # # # # # # Task_3 code end # # # # # # # # # #



# # # # # # # # # # # Task_4 code start # # # # # # # # # #


# Create a Bastion Host instance for secure access to private subnets
resource "aws_instance" "bastion_host" {
  ami           = var.ec2_ami_ubuntu
  instance_type = var.ec2_instance_bastion
  subnet_id     = aws_subnet.public[0].id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_icmp.id,
    aws_security_group.allow_k3s.id,
    aws_security_group.allow_web.id
  ]
  key_name = aws_key_pair.my_key.key_name
  tags = {
    Name = "Bastion Node"
  }
}

# Create a K3S Server Node ec2 instance in Private nerwork
resource "aws_instance" "server_node" {
  ami           = var.ec2_ami_k3s
  instance_type = var.ec2_instance_k3s
  subnet_id     = aws_subnet.private[0].id
  vpc_security_group_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.allow_icmp.id,
    aws_security_group.allow_k3s.id,
    aws_security_group.allow_web.id
  ]
  key_name = aws_key_pair.my_key.key_name
  # Specify the fixed private IP address
  private_ip = var.server_node_fixed_private_ip
  tags = {
    Name = "K3S Server node"
  }
  # This installs K3S server node and Helm
  user_data = <<-EOF
    #!/bin/bash
    # Install K3S
    curl -sfL https://get.k3s.io/ | INSTALL_K3S_EXEC="server" sh -s - --token ${var.k3s_token}
    # Install Helm
    curl -sfL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | sh -s -
    # fix Jenkins pod start problem
    sudo mkdir -p /data/jenkins-volume
    sudo chown -R 1000:1000 /data/jenkins-volume
  EOF
}

# # Create a K3S Agent Node ec2 instance in Private nerwork. Uncomment it, if you want to create an agent node.
# resource "aws_instance" "agent_node_1" {
#   ami           = var.ec2_ami_k3s
#   instance_type = var.ec2_instance_k3s
#   subnet_id     = aws_subnet.private[1].id
#   vpc_security_group_ids = [
#     aws_security_group.allow_ssh.id,
#     aws_security_group.allow_icmp.id,
#     aws_security_group.allow_k3s.id,
#     aws_security_group.allow_http.id,
#     aws_security_group.allow_https.id
#   ]
#   key_name = aws_key_pair.my_key.key_name
#   tags = {
#     Name = "K3S Agent node 1 - test"
#   }
#   # This installs k3s agent node and joins it to a server node
#   user_data = <<-EOF
#     #!/bin/bash
#     curl -sfL https://get.k3s.io/ | INSTALL_K3S_EXEC="agent" K3S_URL=https://${aws_instance.server_node.private_ip}:6443/ K3S_TOKEN=${var.k3s_token} sh -s -
#   EOF
#   depends_on = [aws_instance.server_node]
# }


# # # # # # # # # # # Task_4 code end # # # # # # # # # #
