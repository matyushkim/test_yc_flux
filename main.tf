terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "y0_AgAAAABwsx0nAATuwQAAAADti3fuwahuPEZHRTCBvFE6X3Cn2Kmep3k"
  cloud_id  = "b1g1f73gcm5vet9spf42"
  folder_id = "b1g5l2llrv845fe4eaqv"
  zone      = "ru-central1-a"
}

# resource "yandex_kubernetes_cluster" "test_fluxcd" {
#   name        = "test_fluxcd"
#   description = "My Kubernetes Cluster"
#   # network_id  = "<ID вашей сети>"

#   master {
#     version = "1.15"
#     zone    = "ru-central1-a"
#   }
# }