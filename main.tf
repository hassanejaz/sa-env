module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = "10.98.0.0/16"
  cluster-name = "${var.cluster-name}"
}

module "subnet" {
  source       = "./modules/subnet"
  vpc_id       = "${module.vpc.vpc_id}"
  public-cidr  = ["10.98.3.0/24", "10.98.4.0/24", "10.98.6.0/24"]
  private-cidr = ["10.98.1.0/24", "10.98.2.0/24", "10.98.5.0/24"]
  cluster-name = "${var.cluster-name}"
}

module "securitygroup" {
  source    = "./modules/securitygroup"
  vpc_id    = "${module.vpc.vpc_id}"
  subnet_id = "${module.subnet.subnet_id}"

}


module "ecr" {
  source    = "./modules/ecr"
  repo_name = "${var.repo_name}"

}

module "iam" {
  source = "./modules/iam"
}

module "cluster" {
  source                                              = "./modules/cluster"
  cluster-name                                        = "${var.cluster-name}"
  eks-cluster-securitygroup                           = "${module.securitygroup.eks-cluster-securitygroup}"
  subnet_id                                           = "${module.subnet.subnet_id}"
  cluster_policy                                      = "${module.iam.cluster_policy}"
  service_policy                                      = "${module.iam.service_policy}"
  eks-cluster-iamrole                                 = "${module.iam.eks-cluster-iamrole}"
  eks-cluster-node                                    = "${module.iam.eks-cluster-node-role}"
  eks-cluster-node-AmazonEKSWorkerNodePolicy          = "${module.iam.node_policy}"
  eks-cluster-node-AmazonEKS_CNI_Policy               = "${module.iam.registry_policy}"
  eks-cluster-node-AmazonEC2ContainerRegistryReadOnly = "${module.iam.cni_policy}"


}

module "workernode" {
  source                           = "./modules/workernode"
  subnet_id                        = "${module.subnet.subnet_id}"
  cluster-name                     = "${var.cluster-name}"
  eks-cluster                      = "${module.cluster.eks-cluster}"
  eks-cluster-node-instanceprofile = "${module.iam.eks-cluster-node-instanceprofile}"
  key_name                         = var.key_name
  eks-cluster-node                 = "${module.securitygroup.eks-cluster-node}"
  autoscale_desired_count          = 1
  autoscale_max_count              = 1
  autoscale_min_count              = 1
}

module "alb" {
  source                     = "./modules/alb/"
  name                       = "alb"
  security_groups            = flatten(["${module.securitygroup.alb-securitygroup}"])
  vpc_id                     = module.vpc.vpc_id
  subnets                    = [module.subnet.subnet_id_public.0.id, module.subnet.subnet_id_public.1.id, module.subnet.subnet_id_public.2.id, ]
}