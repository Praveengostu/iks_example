# iks_example

A Terraform configuration for creating a multi AZ cluster. This template provisions 
 - A Subnet with the ip_version and capacity
 - A cluster with default worker pool with the default pool size
 - Two worker pools
**Note:**Currently IBM terraform provider does not support vlan spanning.
This configuration template is tested for IBM Cloud Provider version v0.12
# Usage with Terraform Binary on your local workstation
You will need to [setup up IBM Cloud provider credentials](#setting-up-provider-credentials) on your local machine. 


# Prerequisite 
1) Download [Terraform binary](https://www.terraform.io/downloads.html).  Unzip it and keep the binary in path ex- /usr/local/bin.
2) Download [IBM Cloud Provider Plugin](https://github.com/IBM-Bluemix/terraform-provider-ibm/releases). Unzip it and keep the binary in path in the same directory where you placed Terraform binary in previous step. You can also build the binary yourself. Please look into [documentation](https://github.com/IBM-Bluemix/terraform-provider-ibm/blob/master/README.md).

# To run this project locally execute the following steps:

- Clone this project.
- You can override default values that are in your variables.tf file.
  - Alternatively these values can be supplied via the command line or environment variables, see https://www.terraform.io/intro/getting-started/variables.html.
  - `terraform plan`: this will perform a dry run to show what infrastructure terraform intends to create
- `terraform apply`: this will create actual infrastructure
- `terraform destroy`: this will destroy all infrastructure which has been created

# Setting up Provider Credentials
To setup the IBM Cloud provider to work with this there are a few options for managing credentials safely; here we'll cover the preferred method using environment variables. Other methods can be used, please see the [Terraform Getting Started Variable documentation](https://www.terraform.io/intro/getting-started/variables.html) for further details.

## Environment Variables using IBMid credentials
You'll need to export the following environment variables:

- `TF_VAR_ibm_bluemix_api_key` - your Bluemix api key
- `TF_VAR_ibm_softlayer_api_key` - your softlayer api key
- `TF_VAR_ibm_softlayer_username` - your softlayer username



On OS X this is achieved by entering the following into your terminal, replacing the `<value>` characters with the actual values (remove the `<>`:

- `export TF_VAR_ibm_bluemix_api_key=<value>`
- `export TF_VAR_ibm_softlayer_api_key=<value>`
- `export TF_VAR_ibm_softlayer_username=<value>`


# Variables

|Variable Name|Description|Default Value|
|-------------|-----------|-------------|
|region   |Region where the cluster to be provisioned||
|machine_type|The machine type of the worker nodes||
|hardware|The level of hardware isolation for your worker node||
|cluster_name|Name of the cluster|cluster|
|default_pool_size|The default pool size of cluster||
|subnet_type|The type of the subnet.||
|ip_version|The IP version of the subnet. Accepted values are 4 and 6.||
|capacity|The size of the subnet||
|datacenter|Datacenter where the cluster to be created||
|vlan_name_public|Name of the public vlan for cluster||
|vlan_name_private|Name of the private vlan for cluster||
|pool_1_datacenter|Datacenter where the vlan to be created for first worker pool||
|pool_1_vlan_name_public|Name of the public vlan for first worker pool||
|pool_1_vlan_name_private|Name of the private vlan for first worker pool||
|pool_1_machine_type|Machine type of the first worker pool||
|pool_1_worker_pool_name|Name of the first worker pool|worker_pool_1|
|pool_1_size|Size of the first worker pool||
|zone_1_zone|Zone value||
|pool_2_datacenter|Datacenter where the vlan to be created for second worker pool||
|pool_2_vlan_name_public|Name of the public vlan for second worker pool||
|pool_2_vlan_name_private|Name of the private vlan for second worker pool||
|pool_2_machine_type|Machine type of the second worker pool||
|pool_2_worker_pool_name|Name of the second worker pool|worker_pool_2|
|pool_2_size|Size of the second worker pool||
|zone_2_zone|Zone value||