# Input variables for the module
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_count" {
  description = "Number of subnets to create"
  type        = number
  default     = 2
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
}