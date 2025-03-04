###################################################################################
# AWS EKS Module
###################################################################################

module "aws-eks-kubernetes-cluster" {
  count                                 = var.use_existing_cluster ? 0 : 1
  source                                = "terraform-aws-modules/eks/aws"
  version                               = "v20.33.1"
  cluster_name                          = var.cluster_name
  cluster_version                       = var.cluster_version
  cluster_enabled_log_types             = var.enable_cluster_log ? var.cluster_enabled_log_types : []
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
  eks_managed_node_groups                = local.node_groups

  cluster_security_group_additional_rules  = merge(local.cluster_security_group_additional_rules, var.cluster_security_group_additional_rules)
  node_security_group_additional_rules     = merge(local.node_security_group_additional_rules, var.node_security_group_additional_rules)
  node_security_group_tags                 = var.node_security_group_tags
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
  authentication_mode                      = var.cluster_authentication_mode
  access_entries                           = var.cluster_access_entries
  fargate_profiles = var.karpenter_fargate_profile_enabled ? {
    karpenter = {
      create       = true
      cluster_name = var.cluster_name
      name         = local.karpenter_profile_name
      subnet_ids   = var.subnet_ids
      selectors = [
        {
          namespace = var.karpenter_fargate_profile_namespace
        }
      ]
      create_iam_role            = var.karpenter_fargate_profile_create_iam_role
      iam_role_use_name_prefix   = true
      iam_role_name              = var.cluster_name
      iam_role_description       = "TrueFoundry IAM role of Karpenter Fargate Profile for cluster ${var.cluster_name}"
      iam_role_attach_cni_policy = var.karpenter_fargate_profile_attach_cni_policy
      iam_role_tags              = local.tags
      tags = merge(
        {
          "faragate-profile" = "karpenter"
        }, local.tags
      )
    }

  } : {}
  tags = local.tags
}
