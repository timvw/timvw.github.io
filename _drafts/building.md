---
title: Leverage Terraform, Azure Container Service, kaniko to create and use container images
author: timvw
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

Create a docker config.json file with the credentials for your container registry:

```bash
cat >config.json <<EOL
{
	"auths": {
		"$(terraform output cr_server)": {
			"auth": "$(echo -n $(terraform output cr_admin_username):$(terraform output cr_admin_password) | base64)",
            "email": "$(terraform output cr_admin_username)"
		}
	}
} 
EOL
```

Make this configfile available as a ConfigMap on k8s:

```bash
kubectl create configmap docker-config --from-file=config.json
```

Use the credentials to create a docker registry secret (for pulling images):

```bash
kubectl create secret docker-registry acr-secret \
  --namespace default \
  --docker-server=https://$(terraform output cr_server) \
  --docker-username=$(terraform output cr_admin_username) \
  --docker-password=$(terraform output cr_admin_password)
```

Now deploy the application we just built and verify that it's working:

```bash
kubectl apply -f hello.yaml
curl -v https://hello.apps.icteam.be
```





