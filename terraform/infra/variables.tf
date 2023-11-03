# variable "node_groups_defaults" {
#   description = "Map of common default values for Node groups."
#   type        = map(any)
#   default = {
#     platform_id   = "standard-v3"
#     node_cores    = 2
#     node_memory   = 2
#     node_gpus     = 0
#     core_fraction = 20
#     disk_type     = "network-ssd"
#     disk_size     = 32
#     preemptible   = true
#     nat           = false
#     ipv4          = true
#     ipv6          = false
#   }
# }

variable "cluster_version" {
  description = "Kubernetes cluster version"
  type        = string
  default     = "1.27"
}

variable "aws_secret_access_key" {
  type    = string
  default = "secret_key"
}

variable "aws_access_key_id" {
  type    = string
  default = "access_key"
}

variable "github_org" {
  type    = string
  default = "matyushkim"
}


variable "github_repository" {
  type    = string
  default = "test_yc_argo"
}

variable "github_token" {
  type        = string
  description = "My GitHub token"
  sensitive   = true
}

variable "github_url" {
  type    = string
  default = "ssh://git@github.com/matyushkim/test_yc_argo.git"
}

variable "service_account_id" {
  type        = string
  description = "Service account ID"
}

variable "folder_id" {
  type        = string
  description = "Folder ID"
  sensitive   = true

}

variable "token" {
  type        = string
  description = "token yc qauth"
  sensitive   = true
}

variable "iam_token" {
  type        = string
  description = "token yc iam"
  sensitive   = true
}
variable "cloud_id" {
  type        = string
  description = "cloud_id"
  sensitive   = true

}

variable "zone" {
  type        = string
  description = "zone"
  default     = "ru-cenrtal1-a"
}

### ПЕРЕМЕННЫЕ ДЛЯ ХРАНИЛИЩА ####

variable "buckets" {
  type = list(object({
    name = string
    acl  = string
  }))
  default = [
    {
      name = "evronelabs-postgresql-store",
      acl  = "public-read"
    },
    {
      name = "evronelabs-prometheus-store",
      acl  = "private"
    },
    {
      name = "evronelabs-loki-store",
      acl  = "private"
    },
    # {
    #   name = "evronelabs-terraform-state-store",
    #   acl  = "private"
    # }
  ]
  description = "List of bucket names with acls"
}

variable "master_locations" {
  description = <<-EOF
    List of locations where the cluster will be created. If the list contains only one
    location, a zonal cluster will be created; if there are three locations, this will create a regional cluster.

    Note: The master locations list may only have ONE or THREE locations.
  EOF
  type = list(object({
    zone      = string
    subnet_id = string
  }))
  # default = [
  #   {
  #     zone      = "ru-central1-a"
  #     subnet_id = "e9bjddqmcqh22k68c3ji"
  #   }
  # ]
  validation {
    condition     = contains([1, 3], length(var.master_locations))
    error_message = "Master locations list should have only one location for Zonal cluster and three locations for Regional!"
  }
}
