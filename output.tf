# From https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/outputs.tf

################################################################################
# Cluster
################################################################################
output "use_existing_cluster" {
  description = "Flag to check if you are using an already existing cluster"
  value       = var.use_existing_cluster
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = var.use_existing_cluster ? data.aws_eks_cluster.eks_cluster[0].arn : module.aws-eks-kubernetes-cluster[0].cluster_arn
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = var.use_existing_cluster ? data.aws_eks_cluster.eks_cluster[0].certificate_authority[0].data : module.aws-eks-kubernetes-cluster[0].cluster_certificate_authority_data
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = var.use_existing_cluster ? data.aws_eks_cluster.eks_cluster[0].endpoint : module.aws-eks-kubernetes-cluster[0].cluster_endpoint
}

output "cluster_id" {
  description = "DEPRECATED - Use cluster_name"
  value       = var.use_existing_cluster ? data.aws_eks_cluster.eks_cluster[0].id : module.aws-eks-kubernetes-cluster[0].cluster_name
}

output "cluster_name" {
  description = "The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready"
  value       = var.use_existing_cluster ? data.aws_eks_cluster.eks_cluster[0].name : module.aws-eks-kubernetes-cluster[0].cluster_name
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
  # value       = var.use_existing_cluster ? data.aws_eks_cluster.eks_cluster[0].identity[0].oidc[0].issuer : module.aws-eks-kubernetes-cluster[0].cluster_oidc_issuer_url
  value = var.use_existing_cluster ? var.existing_cluster_oidc_issuer_url : module.aws-eks-kubernetes-cluster[0].cluster_oidc_issuer_url
}

output "cluster_platform_version" {
  description = "Platform version for the cluster"
  value       = var.use_existing_cluster ? data.aws_eks_cluster.eks_cluster[0].platform_version : module.aws-eks-kubernetes-cluster[0].cluster_platform_version
}

output "cluster_status" {
  description = "Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`"
  value       = var.use_existing_cluster ? data.aws_eks_cluster.eks_cluster[0].status : module.aws-eks-kubernetes-cluster[0].cluster_status
}

output "cluster_primary_security_group_id" {
  description = "Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console"
  value       = var.use_existing_cluster ? data.aws_eks_cluster.eks_cluster[0].vpc_config[0].cluster_security_group_id : module.aws-eks-kubernetes-cluster[0].cluster_primary_security_group_id
}

################################################################################
# Cluster Security Group
################################################################################

output "cluster_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the cluster security group"
  value       = var.use_existing_cluster ? "" : module.aws-eks-kubernetes-cluster[0].cluster_security_group_arn
}

output "cluster_security_group_id" {
  description = "ID of the cluster security group"
  value       = var.use_existing_cluster ? data.aws_eks_cluster.eks_cluster[0].vpc_config[0].cluster_security_group_id : module.aws-eks-kubernetes-cluster[0].cluster_security_group_id
}

################################################################################
# Node Security Group
################################################################################

output "node_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the node shared security group"
  value       = var.use_existing_cluster ? "" : module.aws-eks-kubernetes-cluster[0].node_security_group_arn
}

output "node_security_group_id" {
  description = "ID of the node shared security group"
  value       = var.use_existing_cluster ? var.existing_cluster_node_security_group_id : module.aws-eks-kubernetes-cluster[0].node_security_group_id
}

################################################################################
# IRSA
################################################################################

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
  value       = var.use_existing_cluster ? var.existing_cluster_oidc_issuer_arn : module.aws-eks-kubernetes-cluster[0].oidc_provider_arn
}

################################################################################
# IAM Role
################################################################################

output "cluster_iam_role_name" {
  description = "IAM role name of the EKS cluster"
  value       = var.use_existing_cluster ? "" : module.aws-eks-kubernetes-cluster[0].cluster_iam_role_name
}

output "cluster_iam_role_arn" {
  description = "IAM role ARN of the EKS cluster"
  value       = var.use_existing_cluster ? "" : module.aws-eks-kubernetes-cluster[0].cluster_iam_role_arn
}

output "cluster_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = var.use_existing_cluster ? "" : module.aws-eks-kubernetes-cluster[0].cluster_iam_role_unique_id
}

################################################################################
# EKS Addons
################################################################################

output "cluster_addons" {
  description = "Map of attribute maps for all EKS cluster addons enabled"
  value       = var.use_existing_cluster ? {} : module.eks_blueprints_addons[0].eks_addons
}

################################################################################
# EKS Identity Provider
################################################################################

output "cluster_identity_providers" {
  description = "Map of attribute maps for all EKS identity providers enabled"
  value       = var.use_existing_cluster ? {} : module.aws-eks-kubernetes-cluster[0].cluster_identity_providers
  sensitive   = true
}

################################################################################
# CloudWatch Log Group
################################################################################

output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created"
  value       = var.use_existing_cluster ? "" : module.aws-eks-kubernetes-cluster[0].cloudwatch_log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created"
  value       = var.use_existing_cluster ? "" : module.aws-eks-kubernetes-cluster[0].cloudwatch_log_group_arn
}

################################################################################
# Fargate Profile
################################################################################

output "fargate_profiles" {
  description = "Map of attribute maps for all EKS Fargate Profiles created"
  value       = var.use_existing_cluster ? {} : module.aws-eks-kubernetes-cluster[0].fargate_profiles
}

################################################################################
# EKS Managed Node Group
################################################################################

output "eks_managed_node_groups" {
  description = "Map of attribute maps for all EKS managed node groups created"
  value       = var.use_existing_cluster ? local.output_eks_managed_node_groups : module.aws-eks-kubernetes-cluster[0].eks_managed_node_groups
}

################################################################################
# Self Managed Node Group
################################################################################

output "self_managed_node_groups" {
  description = "Map of attribute maps for all self managed node groups created"
  value       = var.use_existing_cluster ? {} : module.aws-eks-kubernetes-cluster[0].self_managed_node_groups
}

################################################################################
# Additional
################################################################################

output "aws_access_entries" {
  description = "Access entries for the EKS cluster security group"
  value       = var.use_existing_cluster ? {} : module.aws-eks-kubernetes-cluster[0].access_entries
}