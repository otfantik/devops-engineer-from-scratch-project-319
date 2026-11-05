resource "yandex_mdb_postgresql_cluster" "bulletins" {
  name        = var.pg_cluster_name
  environment = "PRESTABLE"
  network_id  = module.yc-vpc.vpc_id

  config {
    version = 16

    resources {
      resource_preset_id = "b2.medium"
      disk_type_id       = "network-hdd"
      disk_size          = 20
    }
  }

  host {
    zone      = var.zone
    subnet_id = module.yc-vpc.private_subnets[var.subnet_cidr].subnet_id
  }
}

resource "yandex_mdb_postgresql_user" "bulletins" {
  cluster_id = yandex_mdb_postgresql_cluster.bulletins.id
  name       = var.pg_user
  password   = var.pg_password
}

resource "yandex_mdb_postgresql_database" "bulletins" {
  cluster_id = yandex_mdb_postgresql_cluster.bulletins.id
  name       = var.pg_database
  owner      = yandex_mdb_postgresql_user.bulletins.name
}