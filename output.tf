# From https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/outputs.tf

################################################################################
# Cluster
################################################################################

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.aws-eks-kubernetes-cluster.cluster_arn
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.aws-eks-kubernetes-cluster.cluster_certificate_authority_data
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = module.aws-eks-kubernetes-cluster.cluster_endpoint
}

output "cluster_id" {
  description = "DEPRECATED - Use cluster_name"
  value       = module.aws-eks-kubernetes-cluster.cluster_name
}

output "cluster_name" {
  description = "The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready"
  value       = module.aws-eks-kubernetes-cluster.cluster_name
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
  value       = module.aws-eks-kubernetes-cluster.cluster_oidc_issuer_url
}

output "cluster_platform_version" {
  description = "Platform version for the cluster"
  value       = module.aws-eks-kubernetes-cluster.cluster_platform_version
}

output "cluster_status" {
  description = "Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`"
  value       = module.aws-eks-kubernetes-cluster.cluster_status
}

output "cluster_primary_security_group_id" {
  description = "Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console"
  value       = module.aws-eks-kubernetes-cluster.cluster_primary_security_group_id
}

################################################################################
# Cluster Security Group
################################################################################

output "cluster_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the cluster security group"
  value       = module.aws-eks-kubernetes-cluster.cluster_security_group_arn
}

output "cluster_security_group_id" {
  description = "ID of the cluster security group"
  value       = module.aws-eks-kubernetes-cluster.cluster_security_group_id
}

################################################################################
# Node Security Group
################################################################################

output "node_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the node shared security group"
  value       = module.aws-eks-kubernetes-cluster.node_security_group_arn
}

output "node_security_group_id" {
  description = "ID of the node shared security group"
  value       = module.aws-eks-kubernetes-cluster.node_security_group_id
}

################################################################################
# IRSA
################################################################################

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if `enable_irsa = true`"
  value       = module.aws-eks-kubernetes-cluster.oidc_provider_arn
}

################################################################################
# IAM Role
################################################################################

output "cluster_iam_role_name" {
  description = "IAM role name of the EKS cluster"
  value       = module.aws-eks-kubernetes-cluster.cluster_iam_role_name
}

output "cluster_iam_role_arn" {
  description = "IAM role ARN of the EKS cluster"
  value       = module.aws-eks-kubernetes-cluster.cluster_iam_role_arn
}

output "cluster_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.aws-eks-kubernetes-cluster.cluster_iam_role_unique_id
}

################################################################################
# EKS Addons
################################################################################

output "cluster_addons" {
  description = "Map of attribute maps for all EKS cluster addons enabled"
  value       = module.aws-eks-kubernetes-cluster.cluster_addons
}

################################################################################
# EKS Identity Provider
################################################################################

output "cluster_identity_providers" {
  description = "Map of attribute maps for all EKS identity providers enabled"
  value       = module.aws-eks-kubernetes-cluster.cluster_identity_providers
  sensitive   = true
}

################################################################################
# CloudWatch Log Group
################################################################################

output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created"
  value       = module.aws-eks-kubernetes-cluster.cloudwatch_log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created"
  value       = module.aws-eks-kubernetes-cluster.cloudwatch_log_group_arn
}

################################################################################
# Fargate Profile
################################################################################

output "fargate_profiles" {
  description = "Map of attribute maps for all EKS Fargate Profiles created"
  value       = module.aws-eks-kubernetes-cluster.fargate_profiles
}

################################################################################
# EKS Managed Node Group
################################################################################

output "eks_managed_node_groups" {
  description = "Map of attribute maps for all EKS managed node groups created"
  value       = module.aws-eks-kubernetes-cluster.eks_managed_node_groups
}

################################################################################
# Self Managed Node Group
################################################################################

output "self_managed_node_groups" {
  description = "Map of attribute maps for all self managed node groups created"
  value       = module.aws-eks-kubernetes-cluster.self_managed_node_groups
}

################################################################################
# Additional
################################################################################

output "aws_access_entries" {
  description = "Access entries for the EKS cluster security group"
  value       = module.aws-eks-kubernetes-cluster.access_entries
}