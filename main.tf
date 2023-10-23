terraform {
  required_version = ">=1.1.5"

  required_providers {
    flux = {
      source = "fluxcd/flux"
    }
    yandex = {
      source = "yandex-cloud/yandex"
    }
    kind = {
      source  = "tehcyx/kind"
      version = ">=0.0.16"
    }
    github = {
      source  = "integrations/github"
      version = ">=5.18.0"
    }
  }
}
provider "yandex" {
  token     = "y0_AgAAAABwsx0nAATuwQAAAADti3fuwahuPEZHRTCBvFE6X3Cn2Kmep3k"
  cloud_id  = "b1g1f73gcm5vet9spf42"
  folder_id = "b1g5l2llrv845fe4eaqv"
  zone      = "ru-central1-a"
}

provider "kind" {}

resource "kind_cluster" "this" {
  name = "flux-e2e"
}
