provider "kubernetes" {
  host                   = module.kube.external_v4_endpoint
  cluster_ca_certificate = module.kube.cluster_ca_certificate
  token                  = var.iam_token
}
resource "kubernetes_namespace" "loki" {
  metadata {
    name = "loki"
  }
}
resource "kubernetes_secret" "aws_credentials" {
  metadata {
    name = kubernetes_namespace.loki.loki
  }
  data = {
    AWS_ACCESS_KEY_ID     = var.aws_access_key_id
    AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
  }
}

resource "kubernetes_namespace" "prometheus" {
  metadata {
    name = "prometheus"
  }
}
resource "kubernetes_secret" "prometheus" {
  metadata {
    name = kubernetes_namespace.prometheus.prometheus
  }
  data = {
    AWS_ACCESS_KEY_ID     = var.aws_access_key_id
    AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
  }
}

resource "kubernetes_namespace" "postgres" {
  metadata {
    name = postgres
  }
}

resource "kubernetes_secret" "prometheus" {
  metadata {
    name = kubernetes_namespace.postgres.postgres
  }
  data = {
    AWS_ACCESS_KEY_ID     = var.aws_access_key_id
    AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
  }
}