output "subnet_id" {
  description = "Subnet ID."
  value       = module.vpc.public_subnets[0]
}


output "vpc_id" {
  description = "VPC ID."
  value       = module.vpc.vpc_id
}

