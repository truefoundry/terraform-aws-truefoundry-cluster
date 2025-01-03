# From https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/variables.tf

################################################################################
# Existing cluster
################################################################################
variable "use_existing_cluster" {
  description = "Flag to use an existing cluster. If this is true, a new EKS cluster will not be created"
  default     = false
  type        = bool
}

variable "existing_cluster_node_role_arn" {
  description = "IAM node role ARN for an existing cluster. This will only be used when use_existing_cluster is true"
  default     = ""
  type        = string

  validation {
    condition     = var.use_existing_cluster == false || var.existing_cluster_node_role_arn != ""
    error_message = "existing_cluster_node_role_arn must be non-empty if use_existing_cluster is true."
  }
}

variable "existing_cluster_node_security_group_id" {
  description = "Node security group for an existing cluster. This will only be used when use_existing_cluster is true."
  default     = ""
  type        = string

  validation {
    condition     = var.use_existing_cluster == false || var.existing_cluster_node_security_group_id != ""
    error_message = "existing_cluster_node_security_group_id must be non-empty if use_existing_cluster is true."
  }
}

variable "existing_cluster_oidc_issuer_arn" {
  description = "OIDC issuer ARN for an existing cluster. This will only be used when use_existing_cluster is true."
  default     = ""
  type        = string

  validation {
    condition     = var.use_existing_cluster == false || var.existing_cluster_oidc_issuer_arn != ""
    error_message = "existing_cluster_oidc_issuer_arn must be non-empty if use_existing_cluster is true."
  }
}

variable "existing_cluster_oidc_issuer_url" {
  description = "OIDC issuer URL for an existing cluster. This will only be used when use_existing_cluster is true."
  default     = ""
  type        = string

  validation {
    condition     = var.use_existing_cluster == false || var.existing_cluster_oidc_issuer_url != ""
    error_message = "existing_cluster_oidc_issuer_url must be non-empty if use_existing_cluster is true."
  }
}

################################################################################
# Cluster
################################################################################

variable "cluster_name" {
  description = "Name of the EKS cluster. If use_existing_cluster is set to true, cluster_name will be used to fetch details only"
  type        = string
}

variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
  default     = ["audit", "api", "authenticator"]
}

variable "enable_cluster_log" {
  description = "Enable cluster control plane logs"
  type        = bool
  default     = true
}

variable "cluster_additional_security_group_ids" {
  description = "List of additional, externally created security group IDs to attach to the cluster control plane"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "A list of subnet IDs where the EKS cluster (ENIs) will be provisioned along with the nodes/node groups. Node groups can be deployed within a different set of subnet IDs from within the node group configuration"
  type        = list(string)
  default     = []
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "cluster_version" {
  description = "EKS cluster version"
  type        = string
  default     = "1.30"
}

variable "cluster_authentication_mode" {
  description = "value of the authentication mode for the EKS cluster"
  type        = string
  default     = "API_AND_CONFIG_MAP"
}

variable "cluster_access_entries" {
  description = "value of the access entries for the EKS cluster"
  type        = any
  default     = {}
}
################################################################################
# CloudWatch Log Group
################################################################################

variable "create_cloudwatch_log_group" {
  description = "Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled"
  type        = bool
  default     = true
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "Number of days to retain log events. Default retention - 7 days"
  type        = number
  default     = 7
}

################################################################################
# Cluster Security Group
################################################################################

variable "vpc_id" {
  description = "ID of the VPC where the cluster and its nodes will be provisioned"
  type        = string
  default     = null
}

variable "cluster_security_group_additional_rules" {
  description = "List of additional security group rules to add to the cluster security group created. Set `source_node_security_group = true` inside rules to set the `node_security_group` as source"
  type        = any
  default     = {}
}

################################################################################
# Node Security Group
################################################################################

variable "node_security_group_additional_rules" {
  description = "List of additional security group rules to add to the node security group created. Set `source_cluster_security_group = true` inside rules to set the `cluster_security_group` as source"
  type        = any
  default     = {}
}

variable "node_security_group_tags" {
  description = "List of node security group tags"
  type        = any
  default     = {}
}

################################################################################
# IRSA
################################################################################

variable "enable_irsa" {
  description = "Determines whether to create an OpenID Connect Provider for EKS to enable IRSA"
  type        = bool
  default     = true
}

variable "openid_connect_audiences" {
  description = "List of OpenID Connect audience client IDs to add to the IRSA provider"
  type        = list(string)
  default     = []
}

################################################################################
# Cluster IAM Role
################################################################################

variable "iam_role_additional_policies" {
  description = "Additional policies to be added to the IAM role"
  type        = map(string)
  default     = {}
}

################################################################################
# Self Managed Node Group
################################################################################

variable "self_managed_node_group_defaults" {
  description = "Self node group defaults"
  type        = any
  default     = {}
}

variable "self_managed_node_groups" {
  description = "Map of self-managed node group definitions to create"
  type        = any
  default     = {}
}

################################################################################
# EKS Managed Node Group
################################################################################

variable "eks_managed_node_group_defaults" {
  description = "Managed node group defaults"
  type        = any
  default     = {}
}

variable "additional_eks_managed_node_groups" {
  description = "Map of additional EKS managed node group definitions to create"
  type        = any
  default     = {}
}

################################################################################
# EKS Managed Initial Node Group
################################################################################
variable "initial_node_pool_enabled" {
  description = "Create al2023 initial node pool for EKS managed node group"
  type        = bool
  default     = true
}

variable "initial_node_pool_ami_type" {
  description = "AMI type for the initial node pool"
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "inital_node_pool_capacity_type" {
  description = "capacity type for the initial node pool"
  type        = string
  default     = "SPOT"
}

variable "initial_node_pool_create_iam_role" {
  description = "Create IAM role for the initial node pool"
  type        = bool
  default     = true
}

variable "initial_node_pool_create_iam_role_policy" {
  description = "Create IAM role policy for the initial node pool"
  type        = bool
  default     = true
}

variable "initial_node_pool_create_node_template" {
  description = "Create node template for the initial node pool"
  type        = bool
  default     = true
}

variable "initial_node_pool_min_size" {
  description = "Minimum size for the initial node pool"
  type        = number
  default     = 2
}

variable "initial_node_pool_max_size" {
  description = "Maximum size for the initial node pool"
  type        = number
  default     = 2
}

variable "initial_node_pool_desired_size" {
  description = "Desired size for the initial node pool"
  type        = number
  default     = 2
}

variable "initial_node_pool_iam_role_attach_cni_policy" {
  description = "Attach CNI policy to IAM role for the initial node pool"
  type        = bool
  default     = true
}

variable "initial_node_pool_iam_role_tags" {
  description = "IAM role tags for the initial node pool"
  type        = map(string)
  default     = {}
}

variable "initial_node_pool_iam_role_additional_policies" {
  description = "Additional policies to be added to the IAM role for the initial node pool"
  type        = map(string)
  default = {
    # Required by Karpenter
    karpenter = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}

variable "initial_node_pool_iam_role_use_name_prefix" {
  description = "Use name prefix for IAM role for the initial node pool"
  type        = bool
  default     = true
}

variable "initial_node_pool_instance_types" {
  description = "Instance types for the initial node pool"
  type        = list(string)
  default     = ["c7i.xlarge", "m7i.xlarge", "r7i.xlarge", "r6i.xlarge", "r6a.xlarge", "c6i.xlarge", "c6a.xlarge", "m6a.xlarge"]
}

variable "initial_node_pool_launch_template_use_name_prefix" {
  description = "Use name prefix for launch template for the initial node pool"
  type        = bool
  default     = true
}

variable "initial_node_pool_metadata_options" {
  description = "Metadata options for the initial node pool"
  type        = map(string)
  default     = {}
}

variable "initial_node_pool_labels" {
  description = "Labels for the initial node pool"
  type        = map(string)
  default = {
    "truefoundry.cloud" = "initial"
  }
}
##################################################################################
## Other variables
##################################################################################
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

##################################################################################
## Karpenter Fargate profile
##################################################################################
variable "karpenter_fargate_profile_enabled" {
  description = "Enable Karpenter Fargate profile"
  type        = bool
  default     = false
}

variable "karpenter_fargate_profile_namespace" {
  description = "value of the namespace where Karpenter is installed"
  type        = string
  default     = "karpenter"
}

variable "karpenter_fargate_profile_create_iam_role" {
  description = "Create IAM role for Karpenter Fargate profile"
  type        = bool
  default     = true
}

variable "karpenter_fargate_profile_attach_cni_policy" {
  description = "Attach CNI policy to IAM role for Karpenter Fargate profile"
  type        = bool
  default     = true
}

##################################################################################
## EKS addons
##################################################################################
# variable "cluster_addons_coredns_enable" {
#   description = "Enable the CoreDNS addon"
#   type        = bool
#   default     = true
# }

variable "cluster_addons_coredns_version" {
  description = "Version of the CoreDNS addon"
  type        = string
  default     = "v1.11.1-eksbuild.9"
}

variable "cluster_addons_coredns_additional_configurations" {
  description = "Additional configurations for the coredns addon"
  type        = any
  default     = {}
}

# variable "cluster_addons_vpc_cni_enable" {
#   description = "Enable the VPC CNI addon"
#   type        = bool
#   default     = true
# }

variable "cluster_addons_vpc_cni_version" {
  description = "Version of the VPC CNI addon"
  type        = string
  default     = "v1.18.2-eksbuild.1"
}

variable "cluster_addons_vpc_cni_additional_configurations" {
  description = "Additional configurations for the VPC CNI addon"
  type        = any
  default     = {}
}

# variable "cluster_addons_kube_proxy_enable" {
#   description = "Enable the kube-proxy addon"
#   type        = bool
#   default     = true
# }

variable "cluster_addons_kube_proxy_version" {
  description = "Version of the kube-proxy addon"
  type        = string
  default     = "v1.30.0-eksbuild.3"
}

variable "cluster_addons_kube_proxy_additional_configurations" {
  description = "Additional configurations for the kube proxy addon"
  type        = any
  default     = {}
}

# variable "cluster_addons_eks_pod_identity_agent_enable" {
#   description = "Enable the EKS Pod Identity Agent addon"
#   type        = bool
#   default     = false
# }

variable "cluster_addons_eks_pod_identity_agent_version" {
  description = "Version of the EKS Pod Identity Agent addon"
  type        = string
  default     = "v1.3.0-eksbuild.1"
}

variable "cluster_addons_eks_pod_identity_agent_additional_configurations" {
  description = "Additional configurations for the kube proxy addon"
  type        = any
  default     = {}
}
