###################################################################################
# AWS EKS Module Addons 
###################################################################################

module "eks_blueprints_addons" {
  count   = var.use_existing_cluster ? 0 : 1
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "1.21.0"

  cluster_name      = module.aws-eks-kubernetes-cluster[0].cluster_name
  cluster_endpoint  = module.aws-eks-kubernetes-cluster[0].cluster_endpoint
  cluster_version   = module.aws-eks-kubernetes-cluster[0].cluster_version
  oidc_provider_arn = module.aws-eks-kubernetes-cluster[0].oidc_provider_arn
  observability_tag = var.cluster_addons_observability_tag

  eks_addons = local.eks_addons

  tags = local.tags
}
