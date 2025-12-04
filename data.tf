data "aws_eks_cluster" "eks_cluster" {
  count = var.use_existing_cluster ? 1 : 0
  name  = var.cluster_name
}

data "aws_partition" "current" {}


data "aws_eks_addon_version" "cluster_addons_coredns_version" {
  count              = var.cluster_addons_coredns_enable ? 1 : 0
  addon_name         = "coredns"
  kubernetes_version = var.cluster_version
}

data "aws_eks_addon_version" "cluster_addons_vpc_cni_version" {
  count              = var.cluster_addons_vpc_cni_enable ? 1 : 0
  addon_name         = "vpc-cni"
  kubernetes_version = var.cluster_version
}

data "aws_eks_addon_version" "cluster_addons_kube_proxy_version" {
  count              = var.cluster_addons_kube_proxy_enable ? 1 : 0
  addon_name         = "kube-proxy"
  kubernetes_version = var.cluster_version
}

data "aws_eks_addon_version" "cluster_addons_eks_pod_identity_agent_version" {
  count              = var.cluster_addons_eks_pod_identity_agent_enable ? 1 : 0
  addon_name         = "eks-pod-identity-agent"
  kubernetes_version = var.cluster_version
}
# To do
# apply data block for openid_connect_provider to fetch openid arn directly using eks cluster oidc[0].issuer[0].url