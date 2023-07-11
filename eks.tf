###################################################################################
# AWS EKS Module
###################################################################################

module "aws-eks-kubernetes-cluster" {
  source                                = "terraform-aws-modules/eks/aws"
  version                               = "v19.15.3"
  cluster_name                          = var.cluster_name
  cluster_version                       = "1.26"
  cluster_enabled_log_types             = var.cluster_enabled_log_types
  cluster_additional_security_group_ids = var.cluster_additional_security_group_ids
  subnet_ids                            = var.subnet_ids
  cluster_endpoint_private_access       = var.cluster_endpoint_private_access
  cluster_endpoint_public_access        = var.cluster_endpoint_public_access
  cluster_endpoint_public_access_cidrs  = var.cluster_endpoint_public_access_cidrs

  create_cloudwatch_log_group            = var.create_cloudwatch_log_group
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  vpc_id                                 = var.vpc_id
  enable_irsa                            = var.enable_irsa
  openid_connect_audiences               = var.openid_connect_audiences
  iam_role_additional_policies           = var.iam_role_additional_policies
  self_managed_node_group_defaults       = var.self_managed_node_group_defaults
  self_managed_node_groups               = var.self_managed_node_groups
  eks_managed_node_group_defaults        = var.eks_managed_node_group_defaults
  eks_managed_node_groups                = var.eks_managed_node_groups

  cluster_security_group_additional_rules = merge(local.cluster_security_group_additional_rules, var.cluster_security_group_additional_rules)
  node_security_group_additional_rules    = merge(local.node_security_group_additional_rules, var.node_security_group_additional_rules)
  node_security_group_tags                = var.node_security_group_tags

  tags = local.tags
}