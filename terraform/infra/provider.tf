provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

terraform {
  required_version = ">=1.1.5"

  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "evronelabs-terraform-state-store"
    region   = var.zone
    key      = "infra/terraform.tfstate"
    # access_key = "value"
    # secret_key = "value"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
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