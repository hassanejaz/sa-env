locals {
  vpc_name = "eks-vpc"
  vpc_cidr = "10.68.0.0/16"
}


module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = local.vpc_cidr
  vpc_name = local.vpc_name
}

module "subnet" {
  source       = "./modules/subnet"
  vpc_id       = module.vpc.vpc_id
  public-cidr  = ["10.69.32.0/27", "10.69.64.0/27", "10.69.128.0/27"]
  private-cidr = ["10.68.32.0/27", "10.68.64.0/27", "10.68.128.0/27"]
  cluster-name = var.cluster-name
}

module "securitygroup" {
  source    = "./modules/securitygroup"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.subnet.subnet_id

}


module "ecr" {
  source    = "./modules/ecr"
  repo_name = var.repo_name
}

module "iam" {
  source = "./modules/iam"
}

module "cluster" {
  source                                              = "./modules/cluster"
  cluster-name                                        = var.cluster-name
  eks-cluster-securitygroup                           = module.securitygroup.eks-cluster-securitygroup
  subnet_id                                           = module.subnet.subnet_id
  cluster_policy                                      = module.iam.cluster_policy
  service_policy                                      = module.iam.service_policy
  eks-cluster-iamrole                                 = module.iam.eks-cluster-iamrole
  eks-cluster-node                                    = module.iam.eks-cluster-node-role
  eks-cluster-node-AmazonEKSWorkerNodePolicy          = module.iam.node_policy
  eks-cluster-node-AmazonEKS_CNI_Policy               = module.iam.registry_policy
  eks-cluster-node-AmazonEC2ContainerRegistryReadOnly = module.iam.cni_policy


}

module "workernode" {
  source                           = "./modules/workernode"
  subnet_id                        = module.subnet.subnet_id
  cluster-name                     = var.cluster-name
  eks-cluster                      = module.cluster.eks-cluster
  eks-cluster-node-instanceprofile = module.iam.eks-cluster-node-instanceprofile
  key_name                         = var.key_name
  eks-cluster-node                 = module.securitygroup.eks-cluster-node
  autoscale_desired_count          = 1
  autoscale_max_count              = 1
  autoscale_min_count              = 1
}