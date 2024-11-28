provider "aws" {
  region = "us-east-1"
}

# Call the network module
module "aurora_network" {
  source      = "mtlmtfe01.mgmt.interac.ca/DevSecOpsHackathon/team10_network/aws"
  version     = "1.1.0"
  vpc_cidr     = "10.0.0.0/16"
  subnet_count = 2
  vpc_name     = "Aurora-VPC"
}

# Create a security group for Aurora
resource "aws_security_group" "aurora_sg" {
  vpc_id = module.aurora_network.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aurora-sg"
  }
}

# Create an Aurora PostgreSQL cluster
resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "aurora-cluster"
  engine                  = "aurora-postgresql"
  engine_version          = "13.9"
  master_username         = "app_admin"
  master_password         = "supersecretpassword"
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"

  vpc_security_group_ids = [aws_security_group.aurora_sg.id]

  db_subnet_group_name = aws_db_subnet_group.aurora_subnets.name
  skip_final_snapshot = true
  tags = {
    Name = "aurora-cluster"
  }
}

# Create a DB subnet group
resource "aws_db_subnet_group" "aurora_subnets" {
  name       = "aurora-subnet-group"
  subnet_ids = module.aurora_network.subnet_ids

  tags = {
    Name = "aurora-subnet-group"
  }
}

resource "aws_rds_cluster_instance" "db_instance" {
  count              = 2
  identifier         = "aurora-instance-${count.index + 1}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = "db.r6g.large"
  engine             = "aurora-postgresql"
}