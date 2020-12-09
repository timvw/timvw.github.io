---
title: Leverage Terraform to create virtual machine scaleset with spot instances
author: timvw
layout: post
---
In a [previous](https://timvw.be/2020/02/10/terraform-azure-k8s-nginx-letsencrypt.html) post I demonstrated how easy it has become to deploy a webapplications with an HTTPS backend on Kubernetes and Azure. Let's expand this cluster with a node pool that is backed by [spot](https://azure.microsoft.com/en-us/pricing/spot/) instances:

```yaml
resource "azurerm_kubernetes_cluster_node_pool" "spot" {
    name                  = "spot"
    kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
    vm_size         = "standard_D2s_v4"

    node_count      = 0
    enable_auto_scaling = true
    min_count = 0
    max_count = 5

    priority = "Spot"
    eviction_policy = "Delete"
    spot_max_price = 0.02

    tags       = var.tags
}
```
