variable "github_token" {
  sensitive = true
  type      = string
  default   = "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"
}

variable "github_org" {
  type    = string
  default = "matyushkim"
}

variable "github_repository" {
  type    = string
  default = "github.com/matyushkim/test_yc_argo"
}

# variable "flux_secret" {
#   default = "${env("flux-cd-yc")}"
# }

# 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