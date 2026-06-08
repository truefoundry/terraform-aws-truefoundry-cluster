mock_provider "aws" {
  mock_data "aws_caller_identity" {
    defaults = {
      account_id = "123456789012"
      arn        = "arn:aws:iam::123456789012:user/test"
      user_id    = "AIDAIOSFODNN7EXAMPLE"
    }
  }

  mock_data "aws_partition" {
    defaults = {
      partition  = "aws"
      dns_suffix = "amazonaws.com"
    }
  }

  mock_data "aws_iam_session_context" {
    defaults = {
      issuer_arn   = "arn:aws:iam::123456789012:user/test"
      issuer_id    = "AIDAIOSFODNN7EXAMPLE"
      issuer_name  = "test"
      session_name = ""
    }
  }

  mock_data "aws_iam_policy_document" {
    defaults = {
      json = "{\"Version\":\"2012-10-17\",\"Statement\":[]}"
    }
  }

  mock_data "aws_region" {
    defaults = {
      name = "us-east-1"
    }
  }

  mock_resource "aws_iam_role" {
    defaults = {
      arn       = "arn:aws:iam::123456789012:role/mock-role"
      unique_id = "AROAIOSFODNN7EXAMPLE"
      name      = "mock-role"
      id        = "mock-role"
    }
  }

  mock_resource "aws_iam_policy" {
    defaults = {
      arn = "arn:aws:iam::123456789012:policy/mock-policy"
      id  = "arn:aws:iam::123456789012:policy/mock-policy"
    }
  }

  mock_resource "aws_kms_key" {
    defaults = {
      arn    = "arn:aws:kms:us-east-1:123456789012:key/mock-key-id"
      key_id = "mock-key-id"
      id     = "mock-key-id"
    }
  }

  mock_resource "aws_launch_template" {
    defaults = {
      id             = "lt-0123456789abcdef0"
      arn            = "arn:aws:ec2:us-east-1:123456789012:launch-template/lt-0123456789abcdef0"
      latest_version = 1
    }
  }

  mock_resource "aws_eks_cluster" {
    defaults = {
      arn      = "arn:aws:eks:us-east-1:123456789012:cluster/test-cluster"
      id       = "test-cluster"
      endpoint = "https://mock.eks.endpoint"
      certificate_authority = [
        {
          data = "bW9jaw=="
        }
      ]
      identity = [
        {
          oidc = [
            {
              issuer = "https://oidc.eks.us-east-1.amazonaws.com/id/MOCK"
            }
          ]
        }
      ]
    }
  }
}

mock_provider "helm" {}

run "tags_applied" {
  command = plan

  variables {
    cluster_name = "test-cluster"
    vpc_id       = "vpc-0123456789abcdef0"
    subnet_ids   = ["subnet-0123456789abcdef0", "subnet-0123456789abcdef1"]
    tags = {
      "cost-center" = "test-123"
    }
    # Disable addons to minimise mock surface
    cluster_addons_coredns_enable                = false
    cluster_addons_vpc_cni_enable                = false
    cluster_addons_kube_proxy_enable             = false
    cluster_addons_eks_pod_identity_agent_enable = false
  }

  # Caller tag wins
  assert {
    condition     = local.tags["cost-center"] == "test-123"
    error_message = "Expected cost-center tag to equal test-123, got: ${local.tags["cost-center"]}"
  }

  # Default module tag is present
  assert {
    condition     = local.tags["terraform-module"] == "cluster"
    error_message = "Expected terraform-module tag to equal cluster, got: ${local.tags["terraform-module"]}"
  }

  # terraform tag is present
  assert {
    condition     = local.tags["terraform"] == "true"
    error_message = "Expected terraform tag to equal true, got: ${local.tags["terraform"]}"
  }

  # cluster-name tag is present
  assert {
    condition     = local.tags["cluster-name"] == "test-cluster"
    error_message = "Expected cluster-name tag to equal test-cluster, got: ${local.tags["cluster-name"]}"
  }

  # karpenter_tags carries full standard tag set plus discovery tag
  assert {
    condition     = local.karpenter_tags["cost-center"] == "test-123"
    error_message = "Expected karpenter_tags cost-center to equal test-123, got: ${local.karpenter_tags["cost-center"]}"
  }

  assert {
    condition     = local.karpenter_tags["terraform-module"] == "cluster"
    error_message = "Expected karpenter_tags terraform-module to equal cluster, got: ${local.karpenter_tags["terraform-module"]}"
  }

  assert {
    condition     = local.karpenter_tags["karpenter.sh/discovery"] == "test-cluster"
    error_message = "Expected karpenter.sh/discovery tag to equal test-cluster, got: ${local.karpenter_tags["karpenter.sh/discovery"]}"
  }
}

run "disable_default_tags" {
  command = plan

  variables {
    cluster_name         = "test-cluster"
    vpc_id               = "vpc-0123456789abcdef0"
    subnet_ids           = ["subnet-0123456789abcdef0", "subnet-0123456789abcdef1"]
    disable_default_tags = true
    tags = {
      "cost-center" = "test-123"
    }
    cluster_addons_coredns_enable                = false
    cluster_addons_vpc_cni_enable                = false
    cluster_addons_kube_proxy_enable             = false
    cluster_addons_eks_pod_identity_agent_enable = false
  }

  # Caller tag still present
  assert {
    condition     = local.tags["cost-center"] == "test-123"
    error_message = "Expected cost-center tag to equal test-123 when disable_default_tags=true, got: ${local.tags["cost-center"]}"
  }

  # Default module tags should NOT be present
  assert {
    condition     = !contains(keys(local.tags), "terraform-module")
    error_message = "Expected terraform-module tag to be absent when disable_default_tags=true"
  }

  assert {
    condition     = !contains(keys(local.tags), "terraform")
    error_message = "Expected terraform tag to be absent when disable_default_tags=true"
  }

  assert {
    condition     = !contains(keys(local.tags), "cluster-name")
    error_message = "Expected cluster-name tag to be absent when disable_default_tags=true"
  }
}
