# VPC Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "VPC CIDR block"
  value       = module.vpc.vpc_cidr_block
}

# ALB Outputs
output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "Zone ID of the load balancer"
  value       = module.alb.alb_zone_id
}

# Database Outputs
output "db_endpoint" {
  description = "Database endpoint"
  value       = module.rds.db_instance_endpoint
}

output "db_port" {
  description = "Database port"
  value       = module.rds.db_instance_port
}

# Application URL
output "application_url" {
  description = "Application URL"
  value       = "http://${module.alb.alb_dns_name}"
}

# SSH Command (si se configura key pair)
output "ssh_command_example" {
  description = "Example SSH command to connect to instances"
  value       = "Note: Instances are in private subnets. Use a bastion host or VPN to connect."
}