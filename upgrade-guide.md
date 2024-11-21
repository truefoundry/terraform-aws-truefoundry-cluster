# terraform-aws-truefoundry-cluster
This guide will help you to migrate your terraform code across versions. Keeping your terraform state to the latest version is always recommeneded

## Upgrade guide from 0.6.x to 0.7.x
1. Ensure that you are running on the latest version of 0.6.x
2. Move to `0.7.0` and run the following command
    ```bash
    terraform init -upgrade
    ```
3. Run the migration script present in the `scripts/` directory
    ```bash
    bash migration-script-7.sh
    ```
7. Run terraform plan to check if there are is diff
    ```bash
    terraform plan
    ```

## Upgrade guide from 0.5.x to 0.6.x

### Pre-requisites
1. Ensure you are running on the version [0.5.2](https://github.com/truefoundry/terraform-aws-truefoundry-cluster/releases/tag/v0.5.2)
2. Ensure that you runnning on the EKS version `1.30` which is the default version in `0.5.2`

## Upgrade changes (manual)
1. Execute the terraform apply with version `0.6.1`. If it fails run the below command to import access entry for cluster creator

    ```bash
    terragrunt import 'module.aws-eks-kubernetes-cluster.aws_eks_access_entry.this["cluster_creator"]' "$IAM_PRINCIPAL_ARN"
    terragrunt import 'module.aws-eks-kubernetes-cluster.aws_eks_access_policy_association.this["cluster_creator_admin"]'   $CLUSTER_NAME#$IAM_PRINCIPAL_ARN#arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy
    ```

2. If you still face any issue, go ahead and delete the access entry created in the EKS console Access tab and then run `terraform apply`