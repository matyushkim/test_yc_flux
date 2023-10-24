### ПЕРЕМЕННЫЕ ДЛЯ ХРАНИЛИЩА ####

variable "buckets" {
  type = list(object({
    name = string
    acl  = string
  }))
  description = "List of bucket names with acls"
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
  description = "token"
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