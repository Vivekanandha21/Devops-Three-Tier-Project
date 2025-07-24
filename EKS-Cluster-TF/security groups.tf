resource "aws_security_group" "eks-cluster-sg" {
  # Define the name and VPC ID of the security group
  name        = "Eks-Cluster-SG"                            # Name of the security group
  vpc_id      = module.vpc.vpc_id                       # VPC ID to which the security group belongs
  description = "Allowing Jump Server" # Description of the security group
  
  # Define inbound (ingress) rules
  ingress  {
      description       = "Allow 443 from Jump Server only" 
      from_port         = 443                                       # Starting port number for the rule
      protocol          = "tcp"                                       # Protocol type (TCP)
      to_port           = 443                                        # Ending port number for the rule
      self              = false                                      # Indicates that the security group does not apply to itself
      cidr_blocks       = ["0.0.0.0/0"]                              // It should be specific IP range
    }
  
  
  # Define outbound (egress) rules
  egress {
    from_port       = 0                # Allowing all outbound traffic (starting port 0)
    protocol        = "-1"              # Allowing all protocols
    to_port         = 0                # Allowing all outbound traffic (ending port 0)
    cidr_blocks     = ["0.0.0.0/0"]    # Allowing all outbound traffic to any IPv4 address
  }
}
