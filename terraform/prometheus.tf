resource "yandex_iam_service_account" "prometheus_operator" {
  name      = "prometheus-operator-sa"
  folder_id = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "prometheus_operator" {
  folder_id = var.folder_id
  role      = "monitoring.editor"
  member    = "serviceAccount:${yandex_iam_service_account.prometheus_operator.id}"
}

output "prometheus_operator_sa_id" {
  description = "Service account ID for Prometheus Operator"
  value       = yandex_iam_service_account.prometheus_operator.id
}