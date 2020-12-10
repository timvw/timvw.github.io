---
title: Leverage Terraform to create virtual machine scaleset with spot instances
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

The nodes in this pool will be [tainted](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/) with kubernetes.azure.com/scalesetpriority=spot:NoSchedule.

For a pod to land on a node in this pool you will have to specify a toleration. Here is how you would do this in [Apache Spark](https://spark.apache.org/):

First create a pod.yml file in which you specify the toleration:

```yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    cluster-autoscaler.kubernetes.io/safe-to-evict: true
spec:
  tolerations:
  - key: "kubernetes.azure.com/scalesetpriority"
    operator: "Equal"
    value: "spot"
    effect: "NoSchedule"
```

And now you can submit the app

```bash
./bin/spark-submit \
  --master k8s://$KUBERNETES_MASTER_API \
  --deploy-mode cluster \
  --name spark-pi \
  --class org.apache.spark.examples.SparkPi \
  --conf spark.executor.instances=1 \
  --conf spark.kubernetes.container.image=timvw/spark:3.0.1-hadoop2.7 \
  --conf spark.kubernetes.driver.podTemplateFile=pod.yml \
  --conf spark.kubernetes.executor.podTemplateFile=pod.yml \
  --conf spark.kubernetes.node.selector.agentpool=spot \
  local:///opt/spark/examples/jars/spark-examples_2.12-3.0.1.jar
```