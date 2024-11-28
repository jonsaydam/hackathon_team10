provider "aws" {
  region = var.region
}

module "vpc" {
  count       =     var.vpc_enabled ? 1 : 0
  source      =     "mtlmtfe01.mgmt.interac.ca/DevSecOpsHackathon/team10_network/aws"
  version     =     "1.3.2"
  region      =     var.region
  env         =     var.env
  vpc_enabled =     var.vpc_enabled
  cidr_block  =     var.cidr_block
  vpc_name    =     local.vpc_name
  azs         =     var.azs
}

resource "aws_security_group" "security_group" {
  count       =     var.vpc_enabled ? 1 : 0
  vpc_id      =     module.vpc[0].vpc_id

  ingress {
    description = "PostgreSQL access"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    # cidr_blocks = flatten([for vpc in [module.vpc[0]] : vpc.private_subnets])
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-security-group"
  }
}

output "security_group_id" {
  value = aws_security_group.security_group[0].id
}

module "aurora" {
  count                           = var.aurora_enabled ? 1 : 0
  source                          = "mtlmtfe01.mgmt.interac.ca/DevSecOpsHackathon/team10_aurora/aws"
  version                         = "1.0.3"
  region                          = var.region
  azs                             = var.azs
  aurora_enabled                  = var.aurora_enabled
  cluster_identifier              = local.cluster_identifier
  instance_class                  = var.instance_class
  engine                          = var.engine 
  engine_version                  = var.engine_version
  database_name                   = local.database_name
  master_username                 = var.master_username
  master_password                 = var.master_password
  subnet_ids                      = flatten([for vpc in [module.vpc[0]] : vpc.public_subnets])
  security_group_ids              = [aws_security_group.security_group[0].id]
  instance_count                  = var.instance_count
  deletion_protection             = var.deletion_protection
  publicly_accessible             = var.publicly_accessible
  kms_key_id                      = local.kms_key_id
  apply_immediately               = var.apply_immediately
  storage_encrypted               = var.storage_encrypted
  backup_retention_period         = var.backup_retention_period
  preferred_backup_window         = var.preferred_backup_window
  preferred_maintenance_window    = var.preferred_maintenance_window
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  depends_on                      = [ module.vpc ]
}

# provider "postgresql" {
#   host     = module.aurora[0].cluster_endpoint
#   port     = 5432
#   username = var.master_username
#   password = var.master_password
#   sslmode  = "require"
# }

# resource "postgresql_database" "my_database" {
#   for_each = toset(["${var.env}-db"])
#   name     = each.value
# }


# # Call the network module
# module "aurora_network" {
#   source       = "mtlmtfe01.mgmt.interac.ca/DevSecOpsHackathon/team10_network/aws"
#   version      = "1.2.0"
#   cidr_block   = var.vpc_cidr
#   vpc_name     = local.vpc_name
#   vpc_enabled  = var.vpc_enabled
#   azs          = var.azs
#   region       = var.region
#   env          = var.app_environment
# }

# # Create a security group for Aurora
# resource "aws_security_group" "aurora_sg" {
#   vpc_id = module.aurora_network.vpc_id

#   ingress {
#     from_port   = 5432
#     to_port     = 5432
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "aurora-sg"
#   }
# }

# # Create an Aurora PostgreSQL cluster
# resource "aws_rds_cluster" "aurora" {
#   cluster_identifier      = "aurora-cluster"
#   engine                  = "aurora-postgresql"
#   engine_version          = "13.9"
#   master_username         = "app_admin"
#   master_password         = "supersecretpassword"
#   backup_retention_period = 7
#   preferred_backup_window = "07:00-09:00"

#   vpc_security_group_ids = [aws_security_group.aurora_sg.id]

#   db_subnet_group_name = aws_db_subnet_group.aurora_subnets.name
#   skip_final_snapshot = true
#   tags = {
#     Name = "aurora-cluster"
#   }
# }

# # Create a DB subnet group
# resource "aws_db_subnet_group" "aurora_subnets" {
#   name       = "aurora-subnet-group"
#   subnet_ids = module.aurora_network.subnet_ids

#   tags = {
#     Name = "aurora-subnet-group"
#   }
# }

# resource "aws_rds_cluster_instance" "db_instance" {
#   count               = 2
#   identifier          = "aurora-instance-${count.index + 1}"
#   cluster_identifier  = aws_rds_cluster.aurora.id
#   instance_class      = "db.r6g.large"
#   engine              = "aurora-postgresql"
#   publicly_accessible = true
# }


