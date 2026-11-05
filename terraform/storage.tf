module "s3" {
  source = "github.com/terraform-yc-modules/terraform-yc-s3.git?ref=1.0.4"

  bucket_name = var.s3_bucket
  folder_id   = var.folder_id

  max_size              = 1073741824
  default_storage_class = "STANDARD"
  force_destroy         = true

  versioning = {
    enabled = true
  }

  anonymous_access_flags = {
    list = true
    read = true
  }
}

resource "yandex_iam_service_account" "s3" {
  name        = "bulletins-s3-sa"
  description = "SA for bulletins S3 bucket"
  folder_id   = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "s3_editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.s3.id}"
}

resource "yandex_iam_service_account_static_access_key" "s3" {
  service_account_id = yandex_iam_service_account.s3.id
  description        = "Static access key for bulletins S3"
}