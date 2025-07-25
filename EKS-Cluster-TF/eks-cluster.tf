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

  eks_managed_node_groups = {
    default = {
      min_size       = 2
      max_size       = 6
      desired_size   = 2
      instance_types = ["t3.medium"]
      ami_type       = "AL2_x86_64"
    }
  }

  cluster_addons = {
    vpc-cni = {
      addon_version = "v1.18.1-eksbuild.1"
    }
    coredns = {
      addon_version = "v1.11.1-eksbuild.9"
    }
    kube-proxy = {
      addon_version = "v1.29.3-eksbuild.2"
    }
    aws-ebs-csi-driver = {
      addon_version = "v1.30.0-eksbuild.1"
    }
  }

  tags = {
    Project     = "three-tier-Project"
    Environment = "dev"
    Owner       = "vk"
  }
}
