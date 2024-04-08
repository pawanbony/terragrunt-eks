terraform {
  # required_version = ">= 1.0.0"

  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 4.30"
    }

    kubernetes = {
        source = "hashicorp/kubernetes"
        version = "~> 2.15.0"
      }

    helm = {
      source  = "hashicorp/helm"
      version = "= 2.5.1"
    }
  }
}