data "aws_eks_cluster" "eks_cluster" {
  count = var.use_existing_cluster ? 1 : 0
  name  = var.cluster_name
}

# To do
# apply data block for openid_connect_provider to fetch openid arn directly using eks cluster oidc[0].issuer[0].url