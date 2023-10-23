# provider "kubernetes" {
#     host                  = module.kube.external_v4_endpoint
#     client_ca_certificate = module.kube.cluster_ca_certificate
#     exec = {
#       api_version = "client.authentication.k8s.io/v1beta1",
#       args        = ["k8s", "create-token"],
#       command     = "yc"
#     }
# }

# resource "kubernetes_secret" "example" {
#   metadata {
#     name = "basic-auth"
#   }

#   data = {
#     username = "admin"
#     password = "P4ssw0rd"
#   }

#   type = "kubernetes.io/basic-auth"
# }