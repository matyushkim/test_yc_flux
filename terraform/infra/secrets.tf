provider "kubernetes" {
  host                   = module.kube.external_v4_endpoint
  cluster_ca_certificate = module.kube.cluster_ca_certificate
  token                  = var.iam_token
}

resource "kubernetes_namespace" "secret" {
  metadata {
    name = "secret"
  }
  depends_on = [module.kube]
}

resource "kubernetes_secret" "replicator" {
  for_each = toset(["postgres", "loki", "grafana", "prometheus", "vault"])
  metadata {
    name      = "${each.key}-aws"
    namespace = kubernetes_namespace.secret.metadata[0].name
    annotations = {
      "replicator.v1.mittwald.de/replicate-to" = "${each.key}"
    }
  }
  data = {
    AWS_ACCESS_KEY_ID     = var.aws_access_key_id
    AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
  }
  depends_on = [kubernetes_namespace.secret]
}
# resource "kubernetes_secret" "loki-aws" {
#   metadata {
#     name      = "loki-aws"
#     namespace = kubernetes_namespace.secret.metadata[0].name
#   }
#   data = {
#     AWS_ACCESS_KEY_ID     = var.aws_access_key_id
#     AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
#   }
#   depends_on = [kubernetes_namespace.loki]
# }

# resource "kubernetes_secret" "prometheus-aws" {
#   metadata {
#     name      = "prometheus-aws"
#     namespace = kubernetes_namespace.secret.metadata[0].name
#   }
#   data = {
#     AWS_ACCESS_KEY_ID     = var.aws_access_key_id
#     AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
#   }
#   depends_on = [kubernetes_namespace.prometheus]
# }

# resource "kubernetes_secret" "postgres-aws" {
#   metadata {
#     name      = "postgres-aws"
#     namespace = kubernetes_namespace.secret.metadata[0].name
#   }
#   data = {
#     AWS_ACCESS_KEY_ID     = var.aws_access_key_id
#     AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
#   }
#   depends_on = [kubernetes_namespace.postgres]
# }

# resource "kubernetes_secret" "vault-aws" {
#   metadata {
#     name      = "vault-aws"
#     namespace = kubernetes_namespace.secret.metadata[0].name
#   }
#   data = {
#     AWS_ACCESS_KEY_ID     = var.aws_access_key_id
#     AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
#   }
#   depends_on = [kubernetes_namespace.vault]
# }


# resource "kubernetes_namespace" "loki" {
#   metadata {
#     name = "loki"
#   }
#   depends_on = [module.kube]
# }
# resource "kubernetes_secret" "loki-aws" {
#   metadata {
#     name      = "loki-aws"
#     namespace = kubernetes_namespace.secret.metadata[0].name
#   }
#   data = {
#     AWS_ACCESS_KEY_ID     = var.aws_access_key_id
#     AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
#   }
#   depends_on = [kubernetes_namespace.loki]
# }

# resource "kubernetes_namespace" "prometheus" {
#   metadata {
#     name = "prometheus"
#   }
#   depends_on = [module.kube]
# }
# resource "kubernetes_secret" "prometheus-aws" {
#   metadata {
#     name      = "prometheus-aws"
#     namespace = kubernetes_namespace.prometheus.metadata[0].name
#   }
#   data = {
#     AWS_ACCESS_KEY_ID     = var.aws_access_key_id
#     AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
#   }
#   depends_on = [kubernetes_namespace.prometheus]
# }

# resource "kubernetes_namespace" "postgres" {
#   metadata {
#     name = "postgres"
#   }
#   depends_on = [module.kube]
# }
# resource "kubernetes_secret" "postgres-aws" {
#   metadata {
#     name      = "postgres-aws"
#     namespace = kubernetes_namespace.postgres.metadata[0].name
#   }
#   data = {
#     AWS_ACCESS_KEY_ID     = var.aws_access_key_id
#     AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
#   }
#   depends_on = [kubernetes_namespace.postgres]
# }

# resource "kubernetes_namespace" "vault" {
#   metadata {
#     name = "vault"
#   }
#   depends_on = [module.kube]
# }
# resource "kubernetes_secret" "vault-aws" {
#   metadata {
#     name      = "vault-aws"
#     namespace = kubernetes_namespace.vault.metadata[0].name
#   }
#   data = {
#     AWS_ACCESS_KEY_ID     = var.aws_access_key_id
#     AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
#   }
#   depends_on = [kubernetes_namespace.vault]
# }
