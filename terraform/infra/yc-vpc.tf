module "yc-vpc" {
  source              = "github.com/terraform-yc-modules/terraform-yc-vpc.git"
  network_name        = "test-module-network"
  network_description = "Test network created with module"
  private_subnets = [{
    name           = "subnet-1"
    zone           = "ru-central1-a"
    v4_cidr_blocks = ["10.10.0.0/24"]
    },
    {
      name           = "subnet-2"
      zone           = "ru-central1-b"
      v4_cidr_blocks = ["10.11.0.0/24"]
    },
    {
      name           = "subnet-3"
      zone           = "ru-central1-c"
      v4_cidr_blocks = ["10.12.0.0/24"]
    }
  ]
}