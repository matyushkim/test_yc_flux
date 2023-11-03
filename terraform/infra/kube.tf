module "kube" {
  source     = "github.com/terraform-yc-modules/terraform-yc-kubernetes"
  network_id = module.yc-vpc.vpc_id

  master_locations = [
    {
      zone      = "ru-central1-a"
      subnet_id = "e9bjddqmcqh22k68c3ji"
    }
  ]

  master_maintenance_windows = [
    {
      day        = "monday"
      start_time = "23:00"
      duration   = "3h"
    }
  ]

  node_groups = {
    "yc-k8s-dev" = {
      description   = "Kubernetes nodes group development"
      platform_id   = "standard-v3"
      node_cores    = 4
      node_memory   = 8
      node_gpus     = 0
      core_fraction = 20
      disk_type     = "network-hdd"
      disk_size     = 30
      preemptible   = true
      nat           = false
      ipv4          = true
      ipv6          = false
      fixed_scale = {
        size = 1
      }
      node_labels = {
        role        = "worker-01"
        environment = "testing"
      }
    },

    # "yc-k8s-prod" = {
    #   description = "Kubernetes nodes group prod"
    #   auto_scale = {
    #     min     = 1
    #     max     = 2
    #     initial = 1
    #   }
    #   node_labels = {
    #     role        = "worker-02"
    #     environment = "prod"
    #   }

    #   max_expansion   = 1
    #   max_unavailable = 1
    # }
  }
}