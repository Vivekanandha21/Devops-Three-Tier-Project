# Data source to fetch the most recent Ubuntu AMI (Amazon Machine Image)
data "aws_ami" "ami" {
  most_recent = true  # Fetch the most recent AMI based on the filter criteria
  
  # Filter to get the AMI by name, specifying the Ubuntu version
  filter {
    name   = "name"  # Filter based on the AMI name
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]  # Ubuntu Jammy 22.04 AMIs
  }

  # Only consider AMIs owned by Canonical (Ubuntu's owner account ID)
  owners = ["767397739074"]  # Canonical's AWS account ID (Ubuntu)
}

resource "aws_key_pair" "key_pair" {
  key_name   = "Jenkins-key-pair"  # Name of the key pair
  public_key = file("~/.ssh/id_rsa.pub")  # Path to your public key file

}

# Resource to launch an EC2 instance
resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ami.image_id  # Use the AMI ID retrieved from the data source
  instance_type          = "t2.2xlarge"  # Instance type (size) for the EC2 instance
  key_name               = var.key_name  # The SSH key name to access the EC2 instance
  subnet_id              = module.vpc.public_subnets[0] # Subnet ID for placing the instance in the public subnet
  vpc_security_group_ids = [aws_security_group.security_groups.id]  # Attach the security group to the instance
  associate_public_ip_address = true 
  iam_instance_profile   = aws_iam_instance_profile.instance-profile.name  # IAM role and instance profile for EC2 (e.g., if you need permissions for accessing AWS services)
  user_data = templatefile("./tools-install.sh", {})  # Using a script to initialize the EC2 instance
  root_block_device {
    volume_size = 30  # Size of the root EBS volume (in GB)
  }
  tags = {
    Name = "Jenkins-Server"  # Tag for the instance (you can change it as per your use case)
  }
}
