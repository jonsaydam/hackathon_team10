variable "env" {
  description = "Environment (e.g., dev, prod)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_enabled" {
  description = "Enable VPC deployment"
  type        = bool
}

variable "aurora_enabled" {
  description = "Enable Aurora deployment"
  type        = bool
}

variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
}

variable "azs" {
  description = "Availability zones for the subnets"
  type        = list(string)
}

variable "cluster_identifier" { 
  type = string 
}
variable "engine_version" { 
  type = string 
}
variable "engine" {
  type        = string
}
variable "database_name" { 
  type = string 
}
variable "master_username" { 
  type = string 
}
variable "master_password" { 
  type = string 
}
variable "backup_retention_period" { 
  type = number 
}
variable "preferred_backup_window" { 
  type = string 
}
variable "preferred_maintenance_window" { 
  type = string 
}
variable "storage_encrypted" { 
  type = bool 
}
variable "kms_key_id" { 
  type = string 
}
variable "deletion_protection" { 
  type = bool 
}
variable "instance_count" { 
  type = number 
}
variable "instance_class" { 
  type = string 
}
variable "publicly_accessible" { 
  type = bool 
}
variable "apply_immediately" { 
  type = bool 
}
variable "auto_minor_version_upgrade" { 
  type = bool 
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
}



