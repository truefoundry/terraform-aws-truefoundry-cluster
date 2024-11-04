# terraform-aws-truefoundry-cluster
Truefoundry EKS Module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.57.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws-eks-kubernetes-cluster"></a> [aws-eks-kubernetes-cluster](#module\_aws-eks-kubernetes-cluster) | terraform-aws-modules/eks/aws | v20.17.2 |
| <a name="module_eks_blueprints_addons"></a> [eks\_blueprints\_addons](#module\_eks\_blueprints\_addons) | aws-ia/eks-blueprints-addons/aws | 1.16.3 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_eks_managed_node_groups"></a> [additional\_eks\_managed\_node\_groups](#input\_additional\_eks\_managed\_node\_groups) | Map of additional EKS managed node group definitions to create | `any` | `{}` | no |
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | Number of days to retain log events. Default retention - 7 days | `number` | `7` | no |
| <a name="input_cluster_access_entries"></a> [cluster\_access\_entries](#input\_cluster\_access\_entries) | value of the access entries for the EKS cluster | `any` | `{}` | no |
| <a name="input_cluster_additional_security_group_ids"></a> [cluster\_additional\_security\_group\_ids](#input\_cluster\_additional\_security\_group\_ids) | List of additional, externally created security group IDs to attach to the cluster control plane | `list(string)` | `[]` | no |
| <a name="input_cluster_addons_coredns_additional_configurations"></a> [cluster\_addons\_coredns\_additional\_configurations](#input\_cluster\_addons\_coredns\_additional\_configurations) | Additional configurations for the coredns addon | `any` | `{}` | no |
| <a name="input_cluster_addons_coredns_version"></a> [cluster\_addons\_coredns\_version](#input\_cluster\_addons\_coredns\_version) | Version of the CoreDNS addon | `string` | `"v1.11.1-eksbuild.9"` | no |
| <a name="input_cluster_addons_eks_pod_identity_agent_additional_configurations"></a> [cluster\_addons\_eks\_pod\_identity\_agent\_additional\_configurations](#input\_cluster\_addons\_eks\_pod\_identity\_agent\_additional\_configurations) | Additional configurations for the kube proxy addon | `any` | `{}` | no |
| <a name="input_cluster_addons_eks_pod_identity_agent_version"></a> [cluster\_addons\_eks\_pod\_identity\_agent\_version](#input\_cluster\_addons\_eks\_pod\_identity\_agent\_version) | Version of the EKS Pod Identity Agent addon | `string` | `"v1.3.0-eksbuild.1"` | no |
| <a name="input_cluster_addons_kube_proxy_additional_configurations"></a> [cluster\_addons\_kube\_proxy\_additional\_configurations](#input\_cluster\_addons\_kube\_proxy\_additional\_configurations) | Additional configurations for the kube proxy addon | `any` | `{}` | no |
| <a name="input_cluster_addons_kube_proxy_version"></a> [cluster\_addons\_kube\_proxy\_version](#input\_cluster\_addons\_kube\_proxy\_version) | Version of the kube-proxy addon | `string` | `"v1.30.0-eksbuild.3"` | no |
| <a name="input_cluster_addons_vpc_cni_additional_configurations"></a> [cluster\_addons\_vpc\_cni\_additional\_configurations](#input\_cluster\_addons\_vpc\_cni\_additional\_configurations) | Additional configurations for the VPC CNI addon | `any` | `{}` | no |
| <a name="input_cluster_addons_vpc_cni_version"></a> [cluster\_addons\_vpc\_cni\_version](#input\_cluster\_addons\_vpc\_cni\_version) | Version of the VPC CNI addon | `string` | `"v1.18.2-eksbuild.1"` | no |
| <a name="input_cluster_authentication_mode"></a> [cluster\_authentication\_mode](#input\_cluster\_authentication\_mode) | value of the authentication mode for the EKS cluster | `string` | `"API_AND_CONFIG_MAP"` | no |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) | `list(string)` | <pre>[<br/>  "audit",<br/>  "api",<br/>  "authenticator"<br/>]</pre> | no |
| <a name="input_cluster_endpoint_private_access"></a> [cluster\_endpoint\_private\_access](#input\_cluster\_endpoint\_private\_access) | Indicates whether or not the Amazon EKS private API server endpoint is enabled | `bool` | `true` | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | Indicates whether or not the Amazon EKS public API server endpoint is enabled | `bool` | `true` | no |
| <a name="input_cluster_endpoint_public_access_cidrs"></a> [cluster\_endpoint\_public\_access\_cidrs](#input\_cluster\_endpoint\_public\_access\_cidrs) | List of CIDR blocks which can access the Amazon EKS public API server endpoint | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_cluster_security_group_additional_rules"></a> [cluster\_security\_group\_additional\_rules](#input\_cluster\_security\_group\_additional\_rules) | List of additional security group rules to add to the cluster security group created. Set `source_node_security_group = true` inside rules to set the `node_security_group` as source | `any` | `{}` | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | EKS cluster version | `string` | `"1.30"` | no |
| <a name="input_create_cloudwatch_log_group"></a> [create\_cloudwatch\_log\_group](#input\_create\_cloudwatch\_log\_group) | Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled | `bool` | `true` | no |
| <a name="input_eks_managed_node_group_defaults"></a> [eks\_managed\_node\_group\_defaults](#input\_eks\_managed\_node\_group\_defaults) | Managed node group defaults | `any` | `{}` | no |
| <a name="input_enable_cluster_log"></a> [enable\_cluster\_log](#input\_enable\_cluster\_log) | Enable cluster control plane logs | `bool` | `true` | no |
| <a name="input_enable_irsa"></a> [enable\_irsa](#input\_enable\_irsa) | Determines whether to create an OpenID Connect Provider for EKS to enable IRSA | `bool` | `true` | no |
| <a name="input_iam_role_additional_policies"></a> [iam\_role\_additional\_policies](#input\_iam\_role\_additional\_policies) | Additional policies to be added to the IAM role | `map(string)` | `{}` | no |
| <a name="input_inital_node_pool_capacity_type"></a> [inital\_node\_pool\_capacity\_type](#input\_inital\_node\_pool\_capacity\_type) | capacity type for the initial node pool | `string` | `"SPOT"` | no |
| <a name="input_initial_node_pool_ami_type"></a> [initial\_node\_pool\_ami\_type](#input\_initial\_node\_pool\_ami\_type) | AMI type for the initial node pool | `string` | `"AL2023_x86_64_STANDARD"` | no |
| <a name="input_initial_node_pool_create_iam_role"></a> [initial\_node\_pool\_create\_iam\_role](#input\_initial\_node\_pool\_create\_iam\_role) | Create IAM role for the initial node pool | `bool` | `true` | no |
| <a name="input_initial_node_pool_create_iam_role_policy"></a> [initial\_node\_pool\_create\_iam\_role\_policy](#input\_initial\_node\_pool\_create\_iam\_role\_policy) | Create IAM role policy for the initial node pool | `bool` | `true` | no |
| <a name="input_initial_node_pool_create_node_template"></a> [initial\_node\_pool\_create\_node\_template](#input\_initial\_node\_pool\_create\_node\_template) | Create node template for the initial node pool | `bool` | `true` | no |
| <a name="input_initial_node_pool_desired_size"></a> [initial\_node\_pool\_desired\_size](#input\_initial\_node\_pool\_desired\_size) | Desired size for the initial node pool | `number` | `2` | no |
| <a name="input_initial_node_pool_enabled"></a> [initial\_node\_pool\_enabled](#input\_initial\_node\_pool\_enabled) | Create al2023 initial node pool for EKS managed node group | `bool` | `true` | no |
| <a name="input_initial_node_pool_iam_role_additional_policies"></a> [initial\_node\_pool\_iam\_role\_additional\_policies](#input\_initial\_node\_pool\_iam\_role\_additional\_policies) | Additional policies to be added to the IAM role for the initial node pool | `map(string)` | <pre>{<br/>  "karpenter": "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"<br/>}</pre> | no |
| <a name="input_initial_node_pool_iam_role_attach_cni_policy"></a> [initial\_node\_pool\_iam\_role\_attach\_cni\_policy](#input\_initial\_node\_pool\_iam\_role\_attach\_cni\_policy) | Attach CNI policy to IAM role for the initial node pool | `bool` | `true` | no |
| <a name="input_initial_node_pool_iam_role_tags"></a> [initial\_node\_pool\_iam\_role\_tags](#input\_initial\_node\_pool\_iam\_role\_tags) | IAM role tags for the initial node pool | `map(string)` | `{}` | no |
| <a name="input_initial_node_pool_iam_role_use_name_prefix"></a> [initial\_node\_pool\_iam\_role\_use\_name\_prefix](#input\_initial\_node\_pool\_iam\_role\_use\_name\_prefix) | Use name prefix for IAM role for the initial node pool | `bool` | `true` | no |
| <a name="input_initial_node_pool_instance_types"></a> [initial\_node\_pool\_instance\_types](#input\_initial\_node\_pool\_instance\_types) | Instance types for the initial node pool | `list(string)` | <pre>[<br/>  "c7i.large",<br/>  "m7i.large",<br/>  "r7i.large",<br/>  "r6i.large",<br/>  "r6a.large",<br/>  "c6i.large",<br/>  "c6a.large",<br/>  "m6a.large"<br/>]</pre> | no |
| <a name="input_initial_node_pool_labels"></a> [initial\_node\_pool\_labels](#input\_initial\_node\_pool\_labels) | Labels for the initial node pool | `map(string)` | <pre>{<br/>  "truefoundry.cloud": "initial"<br/>}</pre> | no |
| <a name="input_initial_node_pool_launch_template_use_name_prefix"></a> [initial\_node\_pool\_launch\_template\_use\_name\_prefix](#input\_initial\_node\_pool\_launch\_template\_use\_name\_prefix) | Use name prefix for launch template for the initial node pool | `bool` | `true` | no |
| <a name="input_initial_node_pool_max_size"></a> [initial\_node\_pool\_max\_size](#input\_initial\_node\_pool\_max\_size) | Maximum size for the initial node pool | `number` | `2` | no |
| <a name="input_initial_node_pool_metadata_options"></a> [initial\_node\_pool\_metadata\_options](#input\_initial\_node\_pool\_metadata\_options) | Metadata options for the initial node pool | `map(string)` | `{}` | no |
| <a name="input_initial_node_pool_min_size"></a> [initial\_node\_pool\_min\_size](#input\_initial\_node\_pool\_min\_size) | Minimum size for the initial node pool | `number` | `2` | no |
| <a name="input_karpenter_fargate_profile_attach_cni_policy"></a> [karpenter\_fargate\_profile\_attach\_cni\_policy](#input\_karpenter\_fargate\_profile\_attach\_cni\_policy) | Attach CNI policy to IAM role for Karpenter Fargate profile | `bool` | `true` | no |
| <a name="input_karpenter_fargate_profile_create_iam_role"></a> [karpenter\_fargate\_profile\_create\_iam\_role](#input\_karpenter\_fargate\_profile\_create\_iam\_role) | Create IAM role for Karpenter Fargate profile | `bool` | `true` | no |
| <a name="input_karpenter_fargate_profile_enabled"></a> [karpenter\_fargate\_profile\_enabled](#input\_karpenter\_fargate\_profile\_enabled) | Enable Karpenter Fargate profile | `bool` | `false` | no |
| <a name="input_karpenter_fargate_profile_namespace"></a> [karpenter\_fargate\_profile\_namespace](#input\_karpenter\_fargate\_profile\_namespace) | value of the namespace where Karpenter is installed | `string` | `"karpenter"` | no |
| <a name="input_node_security_group_additional_rules"></a> [node\_security\_group\_additional\_rules](#input\_node\_security\_group\_additional\_rules) | List of additional security group rules to add to the node security group created. Set `source_cluster_security_group = true` inside rules to set the `cluster_security_group` as source | `any` | `{}` | no |
| <a name="input_node_security_group_tags"></a> [node\_security\_group\_tags](#input\_node\_security\_group\_tags) | List of node security group tags | `any` | `{}` | no |
| <a name="input_openid_connect_audiences"></a> [openid\_connect\_audiences](#input\_openid\_connect\_audiences) | List of OpenID Connect audience client IDs to add to the IRSA provider | `list(string)` | `[]` | no |
| <a name="input_self_managed_node_group_defaults"></a> [self\_managed\_node\_group\_defaults](#input\_self\_managed\_node\_group\_defaults) | Self node group defaults | `any` | `{}` | no |
| <a name="input_self_managed_node_groups"></a> [self\_managed\_node\_groups](#input\_self\_managed\_node\_groups) | Map of self-managed node group definitions to create | `any` | `{}` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs where the EKS cluster (ENIs) will be provisioned along with the nodes/node groups. Node groups can be deployed within a different set of subnet IDs from within the node group configuration | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where the cluster and its nodes will be provisioned | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_access_entries"></a> [aws\_access\_entries](#output\_aws\_access\_entries) | Access entries for the EKS cluster security group |
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | Arn of cloudwatch log group created |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | Name of cloudwatch log group created |
| <a name="output_cluster_addons"></a> [cluster\_addons](#output\_cluster\_addons) | Map of attribute maps for all EKS cluster addons enabled |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The Amazon Resource Name (ARN) of the cluster |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server |
| <a name="output_cluster_iam_role_arn"></a> [cluster\_iam\_role\_arn](#output\_cluster\_iam\_role\_arn) | IAM role ARN of the EKS cluster |
| <a name="output_cluster_iam_role_name"></a> [cluster\_iam\_role\_name](#output\_cluster\_iam\_role\_name) | IAM role name of the EKS cluster |
| <a name="output_cluster_iam_role_unique_id"></a> [cluster\_iam\_role\_unique\_id](#output\_cluster\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | DEPRECATED - Use cluster\_name |
| <a name="output_cluster_identity_providers"></a> [cluster\_identity\_providers](#output\_cluster\_identity\_providers) | Map of attribute maps for all EKS identity providers enabled |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster for the OpenID Connect identity provider |
| <a name="output_cluster_platform_version"></a> [cluster\_platform\_version](#output\_cluster\_platform\_version) | Platform version for the cluster |
| <a name="output_cluster_primary_security_group_id"></a> [cluster\_primary\_security\_group\_id](#output\_cluster\_primary\_security\_group\_id) | Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console |
| <a name="output_cluster_security_group_arn"></a> [cluster\_security\_group\_arn](#output\_cluster\_security\_group\_arn) | Amazon Resource Name (ARN) of the cluster security group |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | ID of the cluster security group |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED` |
| <a name="output_eks_managed_node_groups"></a> [eks\_managed\_node\_groups](#output\_eks\_managed\_node\_groups) | Map of attribute maps for all EKS managed node groups created |
| <a name="output_fargate_profiles"></a> [fargate\_profiles](#output\_fargate\_profiles) | Map of attribute maps for all EKS Fargate Profiles created |
| <a name="output_node_security_group_arn"></a> [node\_security\_group\_arn](#output\_node\_security\_group\_arn) | Amazon Resource Name (ARN) of the node shared security group |
| <a name="output_node_security_group_id"></a> [node\_security\_group\_id](#output\_node\_security\_group\_id) | ID of the node shared security group |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | The ARN of the OIDC Provider if `enable_irsa = true` |
| <a name="output_self_managed_node_groups"></a> [self\_managed\_node\_groups](#output\_self\_managed\_node\_groups) | Map of attribute maps for all self managed node groups created |
<!-- END_TF_DOCS -->