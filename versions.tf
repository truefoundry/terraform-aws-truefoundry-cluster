terraform {
  required_version = "~> 1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.57"
    }
    # Added here because the upstream provider breaks
    # https://github.com/aws-ia/terraform-aws-eks-blueprints-addons/issues/452
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9"
    }
  }
}