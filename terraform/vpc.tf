module "yc-vpc" {
  source              = "github.com/terraform-yc-modules/terraform-yc-vpc.git?ref=1.0.9"
  network_name        = var.vpc_name
  network_description = "K8s network"
  private_subnets = [
    {
      name           = var.subnet_name
      zone           = var.zone
      v4_cidr_blocks = [var.subnet_cidr]
    }
  ]
}