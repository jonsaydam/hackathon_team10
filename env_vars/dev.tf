terraform { 
  cloud { 
    
    organization = "DevSecOpsHackathon" 

    workspaces { 
      name = "hackathon_team10_np" 
    } 
  } 
}

variable "env" {
default = "test" 
}

variable "cidr_block" {
  default = "10.0.0.0/16"
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

variable "engine" {
  default  = "aurora-postgresql"
}

variable "engine_version" {
  default  = "15.4"
}

variable "master_username" {
  default  = "app_admin"
}

variable "backup_retention_period" {
  default  = 7
}

variable "storage_encrypted" {
  default  = true
}

variable "deletion_protection" {
  default  = false
}

variable "preferred_backup_window" {
  default  = "07:00-09:00"
}

variable "preferred_maintenance_window" {
  default  = "Sun:23:00-Mon:01:00"
}

variable "enabled_cloudwatch_logs_exports" {
  default  = ["postgresql"]
}

variable "instance_count" {
  default  = 2
}

variable "instance_class" {
  default  = "db.t3.medium"
}

variable "publicly_accessible" {
  default  = true
}

variable "apply_immediately" {
  default  = true
}

variable "auto_minor_version_upgrade" {
  default  = true
}
           
locals {
  vpc_name  =  "vpc-${var.env}"
  cluster_identifier = "${var.env}-aurora-cluster"
  kms_key_id  = "alias/${var.env}-aurora-kms"
}

variable "DB_PASSWORD"{
}
