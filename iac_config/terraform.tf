terraform {
  required_providers {
    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "1.24.0"
    },
    aws    = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
    vault  = {
      source  = "hashicorp/vault"
      version = "4.5.0"
    }
  }
}
