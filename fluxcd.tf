provider "flux" {
  kubernetes = {
    host                  = module.kube.external_v4_endpoint
    client_ca_certificate = module.kube.cluster_ca_certificate
    # cluster_ca_certificate = yandex_kubernetes_cluster.zonal_k8s_cluster.master[0].cluster_ca_certificate
    exec = {
      api_version = "client.authentication.k8s.io/v1beta1",
      args        = ["k8s", "create-token"],
      command     = "yc"
    }
    #  token = data.aws_eks_cluster_auth.cluster.token 
  } #iam
  git = {
    url = "ssh://git@github.com/matyushkim/test_yc_argo.git"
    ssh = {
      username    = "git"
      private_key = "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"
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
  repository = "ssh://git@github.com/matyushkim/test_yc_argo.git"
  key        = "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"
  read_only  = "false"
}

resource "flux_bootstrap_git" "this" {
  depends_on = [github_repository_deploy_key.this]

  path = "gitops/clusters/brf"

  components_extra = ["image-reflector-controller", "image-automation-controller"]

  kustomization_override = file("${path.module}/fluxcd/kustomization.yaml")
}