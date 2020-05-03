resource "aws_eks_cluster" "eks-cluster" {
  name     = var.cluster-name
  role_arn = var.eks-cluster-iamrole.arn

  vpc_config {
    security_group_ids = [var.eks-cluster-securitygroup.id]
    subnet_ids         = var.subnet_id
  }

  depends_on = [
    "var.cluster_policy",
    "var.service_policy",
  ]
}

resource "aws_eks_node_group" "eks-node" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "eks-node"
  node_role_arn   = var.eks-cluster-node
  subnet_ids      = var.subnet_id

  scaling_config {
    desired_size = 3
    max_size     = 6
    min_size     = 3
  }
  depends_on = [
    "var.eks-cluster-node-AmazonEKSWorkerNodePolicy",
    "var.eks-cluster-node-AmazonEKS_CNI_Policy",
    "var.eks-cluster-node-AmazonEC2ContainerRegistryReadOnly",

  ]
}
