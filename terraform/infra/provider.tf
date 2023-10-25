provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

terraform {
  required_version = ">=1.1.5"

  backend "s3" {
    bucket                      = "evronelabs-terraform-state-store"
    key                         = "infra/terraform.tfstate"
    region                      = "ru-central1"
    endpoint                    = "storage.yandexcloud.net"
    access_key                  = var.access_key
    secret_key                  = var.secret_key
    encrypt                     = false
    skip_credentials_validation = true
    skip_region_validation      = true
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
