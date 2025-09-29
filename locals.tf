locals {
  tags = merge(
    {
      "terraform-module" = "eks"
      "terraform"        = "true"
      "cluster-name"     = var.cluster_name
    },
    var.tags
  )

  karpenter_tags = merge(
    {
      "karpenter.sh/discovery" = var.cluster_name
    },
    var.tags
  )

  # Default node security group rule only allows ephemeral ports 1025-65535. https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1779#issuecomment-1203398170
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }

    truefoundry_istiod_webhook_ingress = {
      description                   = "Cluster API to node 15017/tcp for istiod webhook"
      protocol                      = "tcp"
      from_port                     = 15017
      to_port                       = 15017
      type                          = "ingress"
      source_cluster_security_group = true
    }

    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

    metrics_server_10250_ing = {
      description = "Node to node metrics server 10250 ingress port"
      protocol    = "tcp"
      from_port   = 10250
      to_port     = 10250
      type        = "ingress"
      self        = true
    }
  }

  node_groups = merge(var.additional_eks_managed_node_groups,
    var.initial_node_pool_enabled ? {
      initial = {
        ami_type = var.initial_node_pool_ami_type
        ami_id   = var.initial_node_pool_ami_id
        block_device_mappings = {
          xvda = {
            device_name = "/dev/xvda"
            ebs = {
              volume_size           = var.initial_node_pool_volume_size
              volume_type           = "gp3"
              delete_on_termination = true
              encrypted             = var.initial_node_pool_encryption_enabled
            }
          }
        }
        capacity_type                   = var.inital_node_pool_capacity_type
        create                          = true
        create_iam_role                 = var.initial_node_pool_create_iam_role
        create_iam_role_policy          = var.initial_node_pool_create_iam_role_policy
        iam_role_arn                    = var.initial_node_pool_iam_role_arn
        create_launch_template          = var.initial_node_pool_create_node_template
        enable_bootstrap_user_data      = var.initial_node_pool_enable_bootstrap_user_data
        min_size                        = var.initial_node_pool_min_size
        max_size                        = var.initial_node_pool_max_size
        desired_size                    = var.initial_node_pool_desired_size
        iam_role_attach_cni_policy      = var.initial_node_pool_iam_role_attach_cni_policy
        iam_role_description            = var.initial_node_pool_iam_role_description != "" ? var.initial_node_pool_iam_role_description : "TrueFoundry EKS initial node group role for ${var.cluster_name}"
        iam_role_tags                   = merge(local.tags, var.initial_node_pool_iam_role_tags)
        iam_role_use_name_prefix        = var.initial_node_pool_iam_role_use_name_prefix
        iam_role_name                   = "${var.cluster_name}-initial"
        instance_types                  = var.initial_node_pool_instance_types
        launch_template_description     = var.initial_node_pool_launch_template_description != "" ? var.initial_node_pool_launch_template_description : "TrueFoundry AL2023 EKS initial node group launch template for ${var.cluster_name}"
        launch_template_name            = "${var.cluster_name}-initial"
        launch_template_use_name_prefix = var.initial_node_pool_launch_template_use_name_prefix
        labels                          = var.initial_node_pool_labels
        iam_role_additional_policies = merge(
          {
            karpenter = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore"
          },
        var.initial_node_pool_iam_role_additional_policies)
        name             = "${var.cluster_name}-initial"
        metadata_options = var.initial_node_pool_metadata_options
        tags             = local.karpenter_tags
        node_repair_config = {
          enabled = var.initial_node_pool_node_repair_enabled
        }
      }
  } : {})

  karpenter_profile_name = "${var.cluster_name}-karpenter"

  // this is used when use_existing_cluster is set to true, so that we don't have to modify eks_managed_node_groups
  output_eks_managed_node_groups = tomap({
    "initial" = {
      iam_role_arn                       = var.existing_cluster_node_role_arn
      launch_template_id                 = ""
      autoscaling_group_schedule_arns    = {}
      iam_role_name                      = ""
      iam_role_unique_id                 = ""
      launch_template_arn                = ""
      launch_template_latest_version     = 0
      launch_template_name               = ""
      node_group_arn                     = ""
      node_group_autoscaling_group_names = []
      node_group_id                      = ""
      node_group_labels                  = {}
      node_group_resources               = []
      node_group_status                  = ""
      node_group_taints                  = []
      platform                           = ""
    }
  })

  eks_addons = merge(
    var.cluster_addons_coredns_enable ? {
      coredns = {
        addon_version        = var.cluster_addons_coredns_version
        configuration_values = jsonencode(var.cluster_addons_coredns_additional_configurations)
      }
    } : {},

    var.cluster_addons_vpc_cni_enable ? {
      vpc-cni = {
        addon_version        = var.cluster_addons_vpc_cni_version
        configuration_values = jsonencode(var.cluster_addons_vpc_cni_additional_configurations)
      }
    } : {},

    var.cluster_addons_kube_proxy_enable ? {
      kube-proxy = {
        addon_version        = var.cluster_addons_kube_proxy_version
        configuration_values = jsonencode(var.cluster_addons_kube_proxy_additional_configurations)
      }
    } : {},

    var.cluster_addons_eks_pod_identity_agent_enable ? {
      eks-pod-identity-agent = {
        addon_version        = var.cluster_addons_eks_pod_identity_agent_version
        configuration_values = jsonencode(var.cluster_addons_eks_pod_identity_agent_additional_configurations)
      }
    } : {}
  )

}
