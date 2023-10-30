resource "kubernetes_secret" "aws_credentials" {
  metadata {
    name      = "aws-credentials"
    namespace = loki
  }

  data = {
    AWS_ACCESS_KEY_ID     = var.access_key
    AWS_SECRET_ACCESS_KEY = var.secret_key
  }
}