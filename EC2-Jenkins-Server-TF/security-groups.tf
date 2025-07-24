resource "aws_security_group" "Jenkins-SG" {
  # Define the name and VPC ID of the security group
  name        = "Jenkins-SG-TF"                            # Name of the security group
  vpc_id      = module.vpc.vpc_id                       # VPC ID to which the security group belongs
  description = "Allowing Jenkins, Sonarqube, SSH Access" # Description of the security group
  
  # Define inbound (ingress) rules
  ingress = [
    for port in [22, 8080, 9000, 9090, 80] : {
      description       = "Allowing Jenkins, Sonarqube, SSH Access"  # Description for each port rule
      from_port         = port                                       # Starting port number for the rule
      protocol          = "tcp"                                       # Protocol type (TCP)
      to_port           = port                                       # Ending port number for the rule
      ipv6_cidr_blocks  = ["::/0"]                                   # Allowing access from all IPv6 addresses
      self              = false                                      # Indicates that the security group does not apply to itself
      prefix_list_ids   = []                                         # No specific prefix list IDs (empty)
      security_groups   = []    # Reference to the security group ID (to allow inbound traffic from the same group)
      cidr_blocks       = ["0.0.0.0/0"]                              # Allowing access from all IPv4 addresses
    }
  ]
  
  # Define outbound (egress) rules
  egress {
    from_port       = 0                # Allowing all outbound traffic (starting port 0)
    protocol        = "-1"              # Allowing all protocols
    to_port         = 0                # Allowing all outbound traffic (ending port 0)
    security_groups = []  # Allowing egress traffic to the same security group
    cidr_blocks     = ["0.0.0.0/0"]    # Allowing all outbound traffic to any IPv4 address
  }
}
