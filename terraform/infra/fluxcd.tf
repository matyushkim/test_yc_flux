provider "flux" {
  kubernetes = {
    host                   = module.kube.external_v4_endpoint
    cluster_ca_certificate = module.kube.cluster_ca_certificate
    token                  = var.token
    # exec = {
    #   api_version = "client.authentication.k8s.io/v1beta1",
    #   args        = ["k8s", "create-token"],
    #   command     = "yc"
    # }
  }
  git = {
    url = var.github_url
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}


provider "github" {
  owner = var.github_org
  token = var.github_token
}

resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "this" {
  title      = "Flux"
  repository = var.github_repository
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}

resource "flux_bootstrap_git" "this" {
  depends_on = [github_repository_deploy_key.this]

  path = "gitops/clusters/project"

  components_extra = ["image-reflector-controller", "image-automation-controller"]

  kustomization_override = file("${path.module}/fluxcd/kustomization.yaml")
}