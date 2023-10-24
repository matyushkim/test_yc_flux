variable "github_org" {
  type    = string
  default = "matyushkim"
}

variable "github_repository" {
  type    = string
  default = "test_yc_argo"
}

variable "github_token" {
  type    = string
  default = "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"
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