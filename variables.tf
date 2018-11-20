variable "region" {}

variable "machine_type" {}

variable "hardware" {}

variable "cluster_name" {
  default = "cluster"
}

variable "subnet_type" {}
variable "ip_version" {}
variable "capacity" {}

variable "datacenter" {}
variable "vlan_name_public" {}
variable "vlan_name_private" {}

variable "pool_1_datacenter" {}
variable "pool_1_vlan_name_public" {}
variable "pool_1_vlan_name_private" {}
variable "pool_1_machine_type" {}

variable "pool_1_worker_pool_name" {
  default = "worker_pool_1"
}

variable "pool_1_size" {}
variable "zone_1_zone" {}

variable "pool_2_datacenter" {}
variable "pool_2_vlan_name_public" {}
variable "pool_2_vlan_name_private" {}
variable "pool_2_machine_type" {}

variable "pool_2_worker_pool_name" {
  default = "worker_pool_2"
}

variable "pool_2_size" {}
variable "zone_2_zone" {}

variable "default_pool_size" {}
