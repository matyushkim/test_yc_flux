provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

terraform {
  required_version = ">=1.1.5"

  backend "s3" {
    key = "infra/terraform.tfstate"
    # dynamodb_table = "aws-terraform-states-lock"
    encrypt = true
  }

  required_providers {
    flux = {
      source = "fluxcd/flux"
    }
    yandex = {
      source = "yandex-cloud/yandex"
    }
    github = {
      source  = "integrations/github"
      version = ">=5.18.0"
    }
  }
}