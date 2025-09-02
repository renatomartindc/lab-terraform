# Local values para tags comunes
locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Owner       = var.owner
    CreatedAt   = timestamp()
  }
}

# Módulo VPC
module "vpc" {
  source = "./modules/vpc"

  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr          = var.vpc_cidr
  availability_zones = var.availability_zones
  common_tags       = local.common_tags
}

# Módulo ALB
module "alb" {
  source = "./modules/alb"

  project_name             = var.project_name
  environment              = var.environment
  vpc_id                   = module.vpc.vpc_id
  public_subnet_ids        = module.vpc.public_subnet_ids
  alb_security_group_id    = aws_security_group.alb.id
  health_check_path        = "/health"
  enable_deletion_protection = false
  common_tags              = local.common_tags

  depends_on = [module.vpc]
}

# Módulo RDS
module "rds" {
  source = "./modules/rds"

  project_name                = var.project_name
  environment                 = var.environment
  instance_class              = var.db_instance_class
  db_name                     = var.db_name
  db_username                 = var.db_username
  db_password                 = var.db_password
  db_subnet_group_name        = module.vpc.db_subnet_group_name
  database_security_group_id  = aws_security_group.database.id
  skip_final_snapshot         = true  # Solo para desarrollo
  deletion_protection         = false # Solo para desarrollo
  common_tags                 = local.common_tags

  depends_on = [module.vpc]
}

# Módulo EC2
module "ec2" {
  source = "./modules/ec2"

  project_name           = var.project_name
  environment           = var.environment
  instance_type         = var.instance_type
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
  private_subnet_ids    = module.vpc.private_app_subnet_ids
  web_security_group_id = aws_security_group.web.id
  target_group_arn      = module.alb.target_group_arn
  db_endpoint           = module.rds.db_instance_endpoint
  ssh_public_key        = file("C:/Users/elsie/.ssh/terraform-lab.pub") # Ajustar ruta según tu key
  common_tags           = local.common_tags

  depends_on = [module.vpc, module.alb, module.rds]
}