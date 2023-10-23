terraform {
  required_version = ">=1.1.5"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = "y0_AgAAAABwsx0nAATuwQAAAADti3fuwahuPEZHRTCBvFE6X3Cn2Kmep3k"
  cloud_id  = "b1g1f73gcm5vet9spf42"
  folder_id = "b1g5l2llrv845fe4eaqv"
  zone      = "ru-central1-a"
}
resource "yandex_kms_symmetric_key" "key-a" {
  name              = "matuskinm-bucket-tes-evrone"
  description       = "description for key matuskinm-bucket-tes-evrone"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // equal to 1 year
}

resource "yandex_storage_bucket" "all_settings" {
  bucket = "matuskinm-bucket-tes-evrone"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}
