resource "azurerm_resource_group" "rg" {
  name      = var.resource_group_name
  location  = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  address_space       = [var.virtual_network_address_prefix]
  tags = var.tags
}

resource "azurerm_subnet" "kubesubnet" {
  name                 = var.aks_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name  

  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.aks_subnet_address_prefix
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.aks_name
  resource_group_name = azurerm_resource_group.rg.name  
  location            = azurerm_resource_group.rg.location

  dns_prefix          = var.aks_dns_prefix
  kubernetes_version  = var.kubernetes_version



  linux_profile {
    admin_username = var.vm_user_name

    ssh_key {
      key_data = file(var.public_ssh_key_path)
    }
  }

  addon_profile {
    kube_dashboard {
      enabled = true
    }
  }

  default_node_pool {
    name            = "agentpool"
    type            = "VirtualMachineScaleSets"
    node_count      = var.aks_agent_count
    vm_size         = var.aks_agent_vm_size
    os_disk_size_gb = var.aks_agent_os_disk_size
    vnet_subnet_id  = azurerm_subnet.kubesubnet.id       
  } 

  role_based_access_control {
    enabled       = var.aks_enable_rbac
  }

  service_principal {
    client_id     = var.aks_service_principal_app_id
    client_secret = var.aks_service_principal_client_secret
  }

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = var.aks_dns_service_ip
    docker_bridge_cidr = var.aks_docker_bridge_cidr
    service_cidr       = var.aks_service_cidr
  }

  tags       = var.tags
}

