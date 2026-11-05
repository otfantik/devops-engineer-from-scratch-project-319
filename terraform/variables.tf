variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud folder ID"
  type        = string
}

variable "zone" {
  description = "Yandex Cloud availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "vpc_name" {
  description = "VPC network name"
  type        = string
  default     = "k8s-net"
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
  default     = "k8s-subnet"
}

variable "subnet_cidr" {
  description = "Subnet CIDR"
  type        = string
  default     = "10.10.0.0/24"
}

variable "k8s_cluster_name" {
  description = "Kubernetes cluster name"
  type        = string
  default     = "k8s-bulletins"
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.30"
}

variable "k8s_node_count" {
  description = "Number of nodes in the node group"
  type        = number
  default     = 1
}

variable "pg_cluster_name" {
  description = "PostgreSQL cluster name"
  type        = string
  default     = "bulletins-pg"
}

variable "pg_database" {
  description = "PostgreSQL database name"
  type        = string
  default     = "bulletins"
}

variable "pg_user" {
  description = "PostgreSQL user name"
  type        = string
  default     = "bulletins_user"
}

variable "pg_password" {
  description = "PostgreSQL user password"
  type        = string
  sensitive   = true
}

variable "s3_bucket" {
  description = "Object Storage bucket name"
  type        = string
  default     = "bulletins-otfanik-319"
}