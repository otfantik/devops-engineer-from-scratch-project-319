resource "yandex_vpc_security_group" "pg_sg" {
  name       = "bulletins-pg-sg"
  network_id = module.yc-vpc.vpc_id

  ingress {
    protocol       = "TCP"
    description    = "PG from K8s nodes subnet"
    port           = 6432
    v4_cidr_blocks = ["10.10.0.0/24"]
  }

  ingress {
    protocol       = "TCP"
    description    = "PG from K8s pods"
    port           = 6432
    v4_cidr_blocks = ["172.17.0.0/16"]
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

resource "yandex_mdb_postgresql_cluster" "bulletins" {
  name               = var.pg_cluster_name
  environment        = "PRESTABLE"
  network_id         = module.yc-vpc.vpc_id
  security_group_ids = [yandex_vpc_security_group.pg_sg.id]

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