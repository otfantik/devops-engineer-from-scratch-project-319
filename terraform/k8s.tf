module "kube" {
  source          = "github.com/terraform-yc-modules/terraform-yc-kubernetes.git?ref=1.1.3"
  network_id      = module.yc-vpc.vpc_id
  cluster_version = "1.35"

  master_locations = [
    for s in module.yc-vpc.private_subnets : {
      zone      = s.zone
      subnet_id = s.subnet_id
    }
  ]

  master_maintenance_windows = [
    {
      day        = "monday"
      start_time = "23:00"
      duration   = "3h"
    }
  ]

  node_groups = {
    "yc-k8s-ng-01" = {
      description = "Node group 1"
      fixed_scale = {
        size = 2
      }
      node_cores    = 2
      node_memory   = 4
      core_fraction = 100
      disk_type     = "network-hdd"
      disk_size     = 40
      preemptible   = true
      platform_id   = "standard-v3"
      node_labels = {
        role        = "worker"
        environment = "dev"
      }
    }
  }
}