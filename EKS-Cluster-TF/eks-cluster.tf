module "eks" {
  source                                 = "terraform-aws-modules/eks/aws"
  version                                = "20.8.4"

  cluster_name                           = local.cluster_name
  cluster_version                        = var.kubernetes_version
  enable_irsa                            = true
  vpc_id                                 = module.vpc.vpc_id
  subnet_ids                             = module.vpc.private_subnets
  cluster_security_group_id              = aws_security_group.eks-cluster-sg.id
  cluster_endpoint_public_access         = false
  cluster_endpoint_private_access        = true
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["t3.medium"]
  }

  node_group = {
    min_size     = 2
    max_size     = 6
    desired_size = 2

    addons = [
      {
        name    = "vpc-cni"
        version = "v1.18.1-eksbuild.1"
      },
      {
        name    = "coredns"
        version = "v1.11.1-eksbuild.9"
      },
      {
        name    = "kube-proxy"
        version = "v1.29.3-eksbuild.2"
      },
      {
        name    = "aws-ebs-csi-driver"
        version = "v1.30.0-eksbuild.1"
      }
    ]
  }

  tags = {
    Project     = "three-tier-Project"  # <-- Replace with your desired project name
    Environment = "dev"              # Optional: dev/test/prod
    Owner       = "vk"               # Optional: who is managing the infra
  }
}

