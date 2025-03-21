# AWS Provider Configuration
provider "aws" {
  region = "us-east-2"
}

# EKS Cluster Creation Module
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.34.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.28"
  
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  enable_irsa              = true
  manage_aws_auth_configmap = true
  create_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = var.rolearn
      username = "fusi"
      groups   = ["system:masters"]
    },
  ]
}

# Kubernetes Provider using module outputs
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.this.token
}

# EKS Cluster Authentication Data (Token)
data "aws_eks_cluster_auth" "this" {
  name = module.eks.cluster_id
}
