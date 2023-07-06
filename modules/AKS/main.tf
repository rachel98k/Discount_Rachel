
## Aks cluster

resource "azurerm_kubernetes_cluster" "aks_discount_cluster" {
  name                = var.cluster_name
  location            = var.cluster_location
  resource_group_name = var.rg_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.node_pool_name
    node_count = 1
    vm_size    = var.d_vmsize  # Smallest possible machine size

    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
}