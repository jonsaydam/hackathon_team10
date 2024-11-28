variable "env" {
default = "dev" 
}

variable "cidr_block" {
  default = "10.0.0.0/24"
}

variable "region" {
  default  = "us-east-1"
}

variable "vpc_enabled" {
  default  = true
}

variable "azs" {
  default  = ["us-east-1a", "us-east-1b"]
}

variable "aurora_enabled" {
  default  = true
}

variable "cluster_identifier" {
  default  = "${env}-aurora-cluster"
}

variable "engine" {
  default  = "aurora-postgresql"
}

variable "engine_version" {
  default  = "15.4"
}

variable "database_name" {
  default  = "${env}-database"
}

variable "master_username" {
  default  = "admin"
}

variable "master_password" {
  default  = "pass"
}

variable "backup_retention_period" {
  default  = 7
}

variable "storage_encrypted" {
  default  = true
}

variable "kms_key_id" {
  default  = "alias/${env}-aurora-kms"
}

variable "deletion_protection" {
  default  = true
}

variable "preferred_backup_window" {
  default  = "07:00-09:00"
}

variable "preferred_maintenance_window" {
  default  = "Sun:23:00-Mon:01:00"
}

variable "enabled_cloudwatch_logs_exports" {
  default  = ["postgresql", "audit"]
}

variable "instance_count" {
  default  = 2
}

variable "instance_class" {
  default  = "db.t3.medium"
}

variable "publicly_accessible" {
  default  = false
}

variable "apply_immediately" {
  default  = true
}

variable "auto_minor_version_upgrade" {
  default  = true
}
           
locals {
   vpc_name  =  "vpc-${var.env}"
}