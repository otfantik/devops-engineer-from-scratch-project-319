module "lockbox" {
  source = "github.com/terraform-yacloud-modules/terraform-yandex-lockbox.git?ref=v1.38.0"

  name        = "bulletins-secrets"
  description = "Application secrets for bulletins"
  folder_id   = var.folder_id

  entries = {
    PG_PASSWORD   = var.pg_password
    S3_ACCESS_KEY = yandex_iam_service_account_static_access_key.s3.access_key
    S3_SECRET_KEY = yandex_iam_service_account_static_access_key.s3.secret_key
  }
}

resource "yandex_iam_service_account" "eso" {
  name      = "external-secrets-sa"
  folder_id = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "eso_lockbox_viewer" {
  folder_id = var.folder_id
  role      = "lockbox.payloadViewer"
  member    = "serviceAccount:${yandex_iam_service_account.eso.id}"
}

resource "yandex_iam_service_account_key" "eso_key" {
  service_account_id = yandex_iam_service_account.eso.id
  description        = "Key for External Secrets Operator"
}