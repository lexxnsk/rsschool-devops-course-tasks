# nacl.tf



# # # # # # # # # # # Task_2 code start # # # # # # # # # #

# Create a Public Network ACL
resource "aws_network_acl" "public_acl" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "Public Network ACL"
  }
}

# Create Inbound Rule for ICMP traffic for the Public Network ACL
resource "aws_network_acl_rule" "inbound_rule_icmp" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number     = 101
  egress          = false
  protocol        = "icmp"
  rule_action     = "allow"
  cidr_block      = "0.0.0.0/0"
  icmp_type       = -1
  icmp_code       = -1
}

# Create Inbound Rule for SSH traffic for the Public Network ACL
resource "aws_network_acl_rule" "inbound_rule_ssh" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number     = 102
  egress          = false
  protocol        = "tcp"
  rule_action     = "allow"
  cidr_block      = "0.0.0.0/0"
  from_port       = 22
  to_port         = 22
}

# Create Inbound Rule for ephemeral ports for the Public Network ACL
# https://alliescomputing.com/knowledge-base/how-to-handle-ephemeral-ports
resource "aws_network_acl_rule" "inbound_rule_ephemeral" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number     = 103
  egress          = false
  protocol        = "tcp"
  rule_action     = "allow"
  cidr_block      = "0.0.0.0/0"
  from_port       = 1024
  to_port         = 65535
}

# Create Outbound Rule for the Public Network ACL
resource "aws_network_acl_rule" "outbound_rule" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number     = 100
  egress          = true
  protocol        = "all"
  rule_action     = "allow"
  cidr_block      = "0.0.0.0/0"
  from_port       = 0
  to_port         = 0
}

# # # # # # # # # # # Task_2 code end # # # # # # # # # #
