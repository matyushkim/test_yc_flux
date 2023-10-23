provider "flux" {
  kubernetes = {
    host                  = module.kube.external_v4_endpoint
    client_ca_certificate = module.kube.cluster_ca_certificate
    # cluster_ca_certificate = yandex_kubernetes_cluster.zonal_k8s_cluster.master[0].cluster_ca_certificate
    # exec = {
    #   api_version = "client.authentication.k8s.io/v1beta1",
    #   args        = ["k8s", "create-token"],
    #   command     = "yc"
    # }
    token = "t1.9euelZqdk5idlpzPkZXKl8aKlZKWke3rnpWaiYuOioubjYnNlpOcm8fLyZTl8_deICZW-e9NVSYI_d3z9x5PI1b5701VJgj9zef1656VmsrNkZvKjpWPnZiOyc_JypjM7_zF656VmsrNkZvKjpWPnZiOyc_JypjM.qQfFJh0qFuSLXOftWEvwtG_k2-k5tn-ABDf-UFBj-K07lY07cSS3cACFcs14NeVWCIe_t6Cp8T47axjGZNdvBg"
  } #iam
  git = {
    url = "ssh://git@github.com/matyushkim/test_yc_argo.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}

provider "github" {
  owner = var.github_org
  token = "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"
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

  path = "fluxcd/"

  components_extra = ["image-reflector-controller", "image-automation-controller"]

  kustomization_override = file("${path.module}/fluxcd/kustomization.yaml")
}