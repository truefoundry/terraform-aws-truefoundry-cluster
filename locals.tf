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
  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "To node 1025-65535"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
  }

  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
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

    metrics_server_10250_eg = {
      description = "Node to node metrics server 10250 egress port"
      protocol    = "tcp"
      from_port   = 10250
      to_port     = 10250
      type        = "egress"
      self        = true # Does not work for fargate
    }
  }

  node_groups = merge(var.additional_eks_managed_node_groups,
    var.initial_node_pool_enabled ? {
      initial = {
        ami_type = var.initial_node_pool_ami_type
        block_device_mappings = {
          xvda = {
            device_name = "/dev/xvda"
            ebs = {
              volume_size           = 100
              volume_type           = "gp3"
              delete_on_termination = true
            }
          }
        }
        capacity_type                   = var.inital_node_pool_capacity_type
        create                          = true
        create_iam_role                 = var.initial_node_pool_create_iam_role
        create_iam_role_policy          = var.initial_node_pool_create_iam_role_policy
        create_launch_template          = var.initial_node_pool_create_node_template
        min_size                        = var.initial_node_pool_min_size
        max_size                        = var.initial_node_pool_max_size
        desired_size                    = var.initial_node_pool_desired_size
        iam_role_attach_cni_policy      = var.initial_node_pool_iam_role_attach_cni_policy
        iam_role_description            = "TrueFoundry EKS initial node group role for ${var.cluster_name}"
        iam_role_tags                   = merge(local.tags, var.initial_node_pool_iam_role_tags)
        iam_role_use_name_prefix        = var.initial_node_pool_iam_role_use_name_prefix
        iam_role_name                   = "${var.cluster_name}-initial"
        instance_types                  = var.initial_node_pool_instance_types
        launch_template_description     = "TrueFoundry AL2023 EKS initial node group launch template for ${var.cluster_name}"
        launch_template_name            = "${var.cluster_name}-initial"
        launch_template_use_name_prefix = var.initial_node_pool_launch_template_use_name_prefix
        labels                          = var.initial_node_pool_labels
        iam_role_additional_policies    = var.initial_node_pool_iam_role_additional_policies
        name                            = "${var.cluster_name}-initial"
        metadata_options                = var.initial_node_pool_metadata_options
        tags                            = local.karpenter_tags
      }
  } : {})

  karpenter_profile_name = "${var.cluster_name}-karpenter"

  // this is used when use_existing_cluster is set to true, so that we don't have to modify eks_managed_node_groups
  // tflint-ignore: terraform_map_duplicate_keys
  output_eks_managed_node_groups = tomap({
    "initial" = {
      autoscaling_group_schedule_arns = {}
      iam_role_arn                    = var.existing_cluster_node_role_arn
      iam_role_unique_id              = {}
      launch_template_arn             = ""
      launch_template_id              = ""
      // tflint-ignore: terraform_map_duplicate_keys
      autoscaling_group_schedule_arns = {}
      iam_role_name                   = ""
      // tflint-ignore: terraform_map_duplicate_keys
      iam_role_unique_id = ""
      // tflint-ignore: terraform_map_duplicate_keys
      launch_template_arn = ""
      // tflint-ignore: terraform_map_duplicate_keys
      launch_template_id                 = ""
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
}