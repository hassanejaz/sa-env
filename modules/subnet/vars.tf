variable "vpc_id" {}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}
variable "cluster-name" {}
variable "public-cidr" {
}
variable "private-cidr" {}
