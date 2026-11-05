output "cluster_id" {
  value = module.kube.cluster_id
}

output "cluster_name" {
  value = module.kube.cluster_name
}

output "cluster_external_v4_endpoint" {
  value = module.kube.external_v4_endpoint
}

output "cluster_get_credentials_cmd" {
  value = module.kube.external_cluster_cmd
}

output "pg_cluster_id" {
  value = yandex_mdb_postgresql_cluster.bulletins.id
}

output "pg_host_fqdn" {
  value = yandex_mdb_postgresql_cluster.bulletins.host[0].fqdn
}

output "pg_database" {
  value = yandex_mdb_postgresql_database.bulletins.name
}

output "pg_user" {
  value = yandex_mdb_postgresql_user.bulletins.name
}

output "pg_password" {
  value     = var.pg_password
  sensitive = true
}

output "s3_bucket" {
  value = module.s3.bucket_name
}

output "s3_access_key" {
  value     = yandex_iam_service_account_static_access_key.s3.access_key
  sensitive = true
}

output "s3_secret_key" {
  value     = yandex_iam_service_account_static_access_key.s3.secret_key
  sensitive = true
}

output "lockbox_secret_id" {
  value = module.lockbox.id
}

output "lockbox_secret_name" {
  value = module.lockbox.name
}