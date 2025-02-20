###################################################################################
# AWS EKS Module Addons 
###################################################################################

module "eks_blueprints_addons" {
  count   = var.use_existing_cluster ? 0 : 1
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "1.19.0"

  cluster_name      = module.aws-eks-kubernetes-cluster[0].cluster_name
  cluster_endpoint  = module.aws-eks-kubernetes-cluster[0].cluster_endpoint
  cluster_version   = module.aws-eks-kubernetes-cluster[0].cluster_version
  oidc_provider_arn = module.aws-eks-kubernetes-cluster[0].oidc_provider_arn
  observability_tag = var.cluster_addons_observability_tag

  eks_addons = {
    coredns = {
      addon_version        = var.cluster_addons_coredns_version
      configuration_values = jsonencode(var.cluster_addons_coredns_additional_configurations)
    }
    vpc-cni = {
      addon_version        = var.cluster_addons_vpc_cni_version
      configuration_values = jsonencode(var.cluster_addons_vpc_cni_additional_configurations)
    }
    kube-proxy = {
      addon_version        = var.cluster_addons_kube_proxy_version
      configuration_values = jsonencode(var.cluster_addons_kube_proxy_additional_configurations)
    }
    eks-pod-identity-agent = {
      addon_version        = var.cluster_addons_eks_pod_identity_agent_version
      configuration_values = jsonencode(var.cluster_addons_eks_pod_identity_agent_additional_configurations)
    }
  }

  tags = local.tags
}
