# Create a public vlan
resource "ibm_network_vlan" "cluster_vlan_public" {
  name       = "${var.vlan_name_public}"
  datacenter = "${var.datacenter}"
  type       = "PUBLIC"
}

# Create a private vlan
resource "ibm_network_vlan" "cluster_vlan_private" {
  name       = "${var.vlan_name_private}"
  datacenter = "${var.datacenter}"
  type       = "PRIVATE"
}

#create a subnet for cluster
resource "ibm_subnet" "portable_subnet" {
  type       = "${var.subnet_type}"
  private    = true
  ip_version = "${var.ip_version}"
  capacity   = "${var.capacity}"
  vlan_id    = "${ibm_network_vlan.cluster_vlan_private.id}"
}

#Create a cluster in a specified datacenter
resource "ibm_container_cluster" "cluster" {
  name              = "${var.cluster_name}"
  datacenter        = "${var.datacenter}"
  no_subnet         = true
  subnet_id         = ["${ibm_subnet.portable_subnet.id}"]
  default_pool_size = "${var.default_pool_size}"
  region            = "${var.region}"
  machine_type      = "${var.machine_type}"
  hardware          = "${var.hardware}"
  public_vlan_id    = "${ibm_network_vlan.cluster_vlan_public.id}"
  private_vlan_id   = "${ibm_network_vlan.cluster_vlan_private.id}"
}

# Create a public vlan for worker pool 1
resource "ibm_network_vlan" "pool_1_vlan_public" {
  name       = "${var.pool_1_vlan_name_public}"
  datacenter = "${var.pool_1_datacenter}"
  type       = "PUBLIC"
}

# Create a private vlan for worker pool 1
resource "ibm_network_vlan" "pool_1_vlan_private" {
  name       = "${var.pool_1_vlan_name_private}"
  datacenter = "${var.pool_1_datacenter}"
  type       = "PRIVATE"
}

#create the first worker pool
resource ibm_container_worker_pool pool_1 {
  worker_pool_name = "${var.pool_1_worker_pool_name}"
  machine_type     = "${var.pool_1_machine_type}"
  cluster          = "${ibm_container_cluster.cluster.id}"
  size_per_zone    = "${var.pool_1_size}"
  hardware         = "shared"
  disk_encryption  = "true"
  region           = "${var.region}"

  labels = {
    "test" = "test-pool-0"
  }
}

#Attach zone to the first worker pool
resource ibm_container_worker_pool_zone_attachment zone_1 {
  cluster         = "${ibm_container_cluster.cluster.id}"
  worker_pool     = "${element(split("/",ibm_container_worker_pool.pool_1.id),1)}"
  zone            = "${var.zone_1_zone}"
  public_vlan_id  = "${ibm_network_vlan.pool_1_vlan_public.id}"
  private_vlan_id = "${ibm_network_vlan.pool_1_vlan_private.id}"
  region          = "${var.region}"
}

# Create a public vlan for worker pool2
resource "ibm_network_vlan" "pool_2_vlan_public" {
  name       = "${var.pool_2_vlan_name_public}"
  datacenter = "${var.pool_2_datacenter}"
  type       = "PUBLIC"
}

# Create a private vlan for workere pool2
resource "ibm_network_vlan" "pool_2_vlan_private" {
  name       = "${var.pool_2_vlan_name_private}"
  datacenter = "${var.pool_2_datacenter}"
  type       = "PRIVATE"
}

#Create the second worker pool
resource ibm_container_worker_pool pool_2 {
  worker_pool_name = "${var.pool_2_worker_pool_name}"
  machine_type     = "${var.pool_2_machine_type}"
  cluster          = "${ibm_container_cluster.cluster.id}"
  size_per_zone    = "${var.pool_2_size}"
  hardware         = "shared"
  disk_encryption  = "true"
  region           = "${var.region}"

  labels = {
    "test" = "test-pool"
  }
}

#Attach a zone to worker pool2
resource ibm_container_worker_pool_zone_attachment zone_2 {
  cluster        = "${ibm_container_cluster.cluster.id}"
  worker_pool    = "${element(split("/",ibm_container_worker_pool.pool_2.id),1)}"
  zone           = "${var.zone_2_zone}"
  region         = "${var.region}"
  public_vlan_id = "${ibm_network_vlan.pool_2_vlan_public.id}"
}
