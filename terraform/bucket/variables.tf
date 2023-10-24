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
}