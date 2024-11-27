variable "app_environment" {
default = "prod" 
}

variable "cidr_block" {
  default = "10.0.1.0/24"
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
