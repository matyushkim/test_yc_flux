provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

terraform {
  required_version = ">=1.1.5"

  backend "s3" {
    # endpoint = "storage.yandexcloud.net"
    # bucket   = "evronelabs-terraform-state-store"
    # region   = "ru-central1"
    # key      = "infra/terraform.tfstate"
    # # access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    # # secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key

    # skip_credentials_validation = true
    # skip_metadata_api_check     = true


    bucket   = "evronelabs-terraform-state-store"
    key      = "infra/terraform.tfstate"
    region   = "ru-central1"
    endpoint = "https://storage.yandexcloud.net"
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
