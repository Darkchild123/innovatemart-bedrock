# EKS Cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = "innovatemart-eks"
  cluster_version = "1.29"
  
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  cluster_endpoint_public_access = true

  # This is the correct way to enable cluster creator admin permissions
  enable_cluster_creator_admin_permissions = true

  # Node Group
  eks_managed_node_groups = {
    main = {
      name           = "main-nodegroup"
      instance_types = ["t3.medium"]
      
      min_size     = 1
      max_size     = 3
      desired_size = 2

      # IAM role for nodes
      iam_role_additional_policies = {
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
        AmazonEKS_CNI_Policy               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      }
    }
  }

  tags = {
    Project = "innovatemart"
  }
}
