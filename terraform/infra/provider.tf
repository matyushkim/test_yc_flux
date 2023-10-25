provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

terraform {
  required_version = ">= 0.13"

  backend "s3" {
    # endpoint = "storage.yandexcloud.net"
    # bucket   = "evronelabs-terraform-state-store"
    # region   = "ru-central1"
    # key      = "infra/terraform.tfstate"
    access_key = "id=aje2j1e1r5t1usd1ujp1"
    # # secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key

    # skip_credentials_validation = true
    # skip_metadata_api_check     = true


    bucket   = "evronelabs-terraform-state-store"
    key      = "infra/terraform.tfstate"
    region   = "ru-central1"
    endpoint = "storage.yandexcloud.net"
    encrypt  = false

    skip_credentials_validation = true
    skip_region_validation      = true
    # skip_bucket_ssencryption    = true
    skip_metadata_api_check = true
    # skip_bucket_root_access     = true
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
