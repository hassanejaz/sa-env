output "repo_url" {
  value = module.ecr.repo_url
}
output "lb_dns" {
    description = ""
    value = module.alb.lb_dns
}