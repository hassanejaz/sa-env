variable "cluster-name" {
  default = "eks-cluster"
}

variable "eks-cluster-securitygroup" {}
variable "eks-cluster-iamrole" {}
variable "subnet_id" {}

variable "cluster_policy" {}
variable "service_policy" {}
variable "eks-cluster-node" {
}
variable "eks-cluster-node-AmazonEKSWorkerNodePolicy" {

}
variable "eks-cluster-node-AmazonEKS_CNI_Policy" {

}
variable "eks-cluster-node-AmazonEC2ContainerRegistryReadOnly" {

}






