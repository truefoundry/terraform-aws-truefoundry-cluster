###################################################################################
# AWS EKS Module Addons 
###################################################################################

module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "1.16.3"

  cluster_name      = module.aws-eks-kubernetes-cluster.cluster_name
  cluster_endpoint  = module.aws-eks-kubernetes-cluster.cluster_endpoint
  cluster_version   = module.aws-eks-kubernetes-cluster.cluster_version
  oidc_provider_arn = module.aws-eks-kubernetes-cluster.oidc_provider_arn

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