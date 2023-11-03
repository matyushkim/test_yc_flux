provider "kubernetes" {
  host                   = module.kube.external_v4_endpoint
  cluster_ca_certificate = module.kube.cluster_ca_certificate
  token                  = var.iam_token
}

resource "kubernetes_namespace" "loki" {
  metadata {
    name = "loki"
  }
  depends_on = [module.kube]
}
resource "kubernetes_secret" "loki-aws" {
  metadata {
    name      = "loki-aws"
    namespace = kubernetes_namespace.loki.metadata[0].name
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
  depends_on = module.kube
}
resource "kubernetes_secret" "prometheus-aws" {
  metadata {
    name      = "prometheus-aws"
    namespace = kubernetes_namespace.prometheus.metadata[0].name
  }
  data = {
    AWS_ACCESS_KEY_ID     = var.aws_access_key_id
    AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
  }
}

resource "kubernetes_namespace" "postgres" {
  metadata {
    name = "postgres"
  }
  depends_on = module.kube
}
resource "kubernetes_secret" "postgres-aws" {
  metadata {
    name      = "postgres-aws"
    namespace = kubernetes_namespace.postgres.metadata[0].name
  }
  data = {
    AWS_ACCESS_KEY_ID     = var.aws_access_key_id
    AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
  }
}