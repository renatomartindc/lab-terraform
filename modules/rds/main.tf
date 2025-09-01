# Random password for database
resource "random_password" "db_password" {
  length  = 16
  special = true
}

# RDS instance
resource "aws_db_instance" "main" {
  identifier             = "${var.project_name}-${var.environment}-db"
  allocated_storage      = var.allocated_storage
  max_allocated_storage  = var.max_allocated_storage
  storage_type           = "gp2"
  storage_encrypted      = true
  engine                 = "mysql"
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password != "" ? var.db_password : random_password.db_password.result
  
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [var.database_security_group_id]
  
  backup_retention_period = var.backup_retention_period
  backup_window          = var.backup_window
  maintenance_window     = var.maintenance_window
  
  skip_final_snapshot = var.skip_final_snapshot
  deletion_protection = var.deletion_protection
  
  performance_insights_enabled = var.performance_insights_enabled
  monitoring_interval         = var.monitoring_interval
  
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.environment}-db"
  })
}

# Store password in AWS Systems Manager Parameter Store
resource "aws_ssm_parameter" "db_password" {
  name        = "/${var.project_name}/${var.environment}/db/password"
  description = "Database password"
  type        = "SecureString"
  value       = var.db_password != "" ? var.db_password : random_password.db_password.result

  tags = var.common_tags
}