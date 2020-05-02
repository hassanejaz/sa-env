output "eks-cluster-node-instanceprofile" {
  value = aws_iam_instance_profile.eks-cluster-node
}

output "eks-cluster-iamrole" {
  value = aws_iam_role.eks-cluster-iamrole
}

output "cluster_policy" {
  value = aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy
}

output "service_policy" {
  value = aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy
}

output "eks-cluster-node-role" {
  value = aws_iam_role.eks-cluster-node.arn
}

output "node_policy" {
  value = aws_iam_role_policy_attachment.eks-cluster-node-AmazonEKSWorkerNodePolicy
}

output "registry_policy" {
  value = aws_iam_role_policy_attachment.eks-cluster-node-AmazonEC2ContainerRegistryReadOnly
}
output "cni_policy" {
  value = aws_iam_role_policy_attachment.eks-cluster-node-AmazonEKS_CNI_Policy
}