# General Configuration
aws_region   = "us-west-2"
project_name = "3tier-webapp"
environment  = "dev"
owner        = "platform-team"

# VPC Configuration
vpc_cidr           = "10.0.0.0/16"
availability_zones = ["us-west-2a", "us-west-2b"]

# EC2 Configuration
instance_type    = "t3.micro"
min_size         = 1
max_size         = 3
desired_capacity = 2

# RDS Configuration
db_instance_class = "db.t3.micro"
db_name          = "webapp"
db_username      = "admin"
db_password      = "change-this-password-123!"  # En producción usar AWS Secrets Manager