---
title: Leverage Terraform, Azure Container Service and kaniko to create and use container images on Kubernetes.
layout: post
---
In this post I demonstrate how easy it has become to build and use container images on Kubernetes (without docker) leveraging [kaniko](https://github.com/GoogleContainerTools/kaniko).

In order to follow along you should clone the sample code from this [repository](https://github.com/timvw/sample-terraform-azure-k8s-acr-kaniko):

```bash
git clone https://github.com/timvw/sample-terraform-azure-k8s-acr-kaniko
```

Create an [Azure Container Registry](https://azure.microsoft.com/en-us/services/container-registry/) with [Terraform](https://www.terraform.io/docs/providers/azurerm/r/container_registry.html)

```bash
terraform init
terraform apply -auto-approve
```

We will use the admin credentials to create a docker registry secret:

```bash
kubectl create secret docker-registry acr-secret \
  --namespace default \
  --docker-server=https://$(terraform output cr_server) \
  --docker-username=$(terraform output cr_admin_username) \
  --docker-password=$(terraform output cr_admin_password)
```

Now we can build an image on our cluster and push it to our container registry:

```bash
kubectl apply -f build-helloworld-job.yaml
kubectl wait --for=condition=complete job/build-helloworld --timeout=300s
```

Now deploy the application we just built and verify that it's working:

```bash
kubectl apply -f helloworld-deploy.yaml
curl -v https://helloworld.apps.icteam.be
```





