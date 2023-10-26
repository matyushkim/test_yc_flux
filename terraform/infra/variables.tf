variable "node_groups_defaults" {
  description = "Map of common default values for Node groups."
  type        = map(any)
  default = {
    platform_id   = "standard-v3"
    node_cores    = 2
    node_memory   = 2
    node_gpus     = 0
    core_fraction = 20
    disk_type     = "network-ssd"
    disk_size     = 32
    preemptible   = true
    nat           = false
    ipv4          = true
    ipv6          = false
  }
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
  description = "token yc"
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
}

### ПЕРЕМЕННЫЕ ДЛЯ ХРАНИЛИЩА ####

variable "buckets" {
  type = list(object({
    name = string
    acl  = string
  }))
  default = [
    {
      name = "evronelabs-webapplication-store",
      acl  = "public-read"
    },
    {
      name = "evronelabs-victoriametrics-store",
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