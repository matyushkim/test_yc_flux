provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

terraform {
  required_version = ">=1.1.5"

  # backend "s3" {
  #   bucket   = "evronelabs-webapplication-store"
  #   key      = "infra/terraform.tfstate"
  #   endpoint = "storage.yandexcloud.net"
  #   region   = var.zone
  #   # dynamodb_table = "aws-terraform-states-lock"
  #   encrypt = true
  #   # terraform init \
  #   # -backend-config="bucket=evronelabs-webapplication-store" \
  #   # -backend-config="endpoint=storage.yandexcloud.net" \
  #   # -backend-config="region= ${{ vars.YC_REGION }} "
  # }

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