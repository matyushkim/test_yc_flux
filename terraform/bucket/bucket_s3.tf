resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = var.service_account_id
  description        = "static access key for object storage"
}


// вариант создания через for each с ключами
resource "yandex_storage_bucket" "this" {
  for_each = { for bucket in var.buckets : bucket.name => bucket }

  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  folder_id  = var.folder_id

  bucket = each.key
  acl    = each.value.acl
}


# вариант создания через count
# resource "yandex_storage_bucket" "bucket" {
#   count  = length(var.buckets)
#   bucket = var.buckets[count.index].name
#   acl    = var.buckets[count.index].acl
# }  