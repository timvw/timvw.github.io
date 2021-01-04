---
date: "2020-02-10T00:00:00Z"
title: Leverage Terraform, NGINX Ingress Controller, cert-manager and Let's Encrypt to quickly create a Kubernetes cluster which can serve webapps over HTTPS.
aliases:
 - /2020/02/10/terraform-azure-k8s-nginx-letsencrypt/
 - /2020/02/10/terraform-azure-k8s-nginx-letsencrypt.html
---
In this post I demonstrate how easy it has become to create a kubernetes cluster which serves webapplications over HTTPS.

In order to follow along you should clone the sample code from this [repository](https://github.com/timvw/sample-terraform-azure-k8s-nginx-letsencrypt):

```bash
git clone https://github.com/timvw/sample-terraform-azure-k8s-nginx-letsencrypt
```

First [configure the azure service principal for Terraform](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html):

```bash
export ARM_CLIENT_ID="XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
export ARM_CLIENT_SECRET="XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
export ARM_SUBSCRIPTION_ID="XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
export ARM_TENANT_ID="XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
```

The resources in this example depend on the following variables: client_id, client_secret, aks_service_principal_app_id and aks_service_principal_client_secret. One way to configure them is by exporting their values as a TF_VAR_xxx:

```bash
export TF_VAR_client_id=$ARM_CLIENT_ID
export TF_VAR_client_secret=$ARM_CLIENT_SECRET
export TF_VAR_aks_service_principal_app_id=$ARM_CLIENT_ID
export TF_VAR_aks_service_principal_client_secret=$ARM_CLIENT_SECRET
```

With all this configuration in place we can instruct Terraform to create the kubernetes cluster:

```bash
terraform init
terraform apply -auto-approve
```

After a couple (~10) of minutes your cluster will be ready. Importing the credentials into your ~/.kube/config can be done as following:

```bash
az aks get-credentials --resource-group k8s-test --name kaz
```

[kubectx](https://github.com/ahmetb/kubectx) is an awesome tool that allows you to easily switch between contexts.

Now it is time to [deploy the NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/). We also need to apply the [azure specific](https://kubernetes.github.io/ingress-nginx/deploy/#azure) additions:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.28.0/deploy/static/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.28.0/deploy/static/provider/cloud-generic.yaml
```

Deploying the NGINX Ingress Controller results in the creation of a loadbalancer and a public ip. Here is how you can fetch that address:

```bash
az network public-ip list | grep -Po '(?<="ipAddress": ")([^"]*)'
```

In this example we want to access our applications as https://XXX.apps.icteam.be.
We achieve this by adding an A-record (the azure public ip address) pointing to *.apps.icteam.be

For the HTTPS part we [install cert-manager](https://cert-manager.io/docs/installation/kubernetes/) and use [Let's Encrypt](https://letsencrypt.org/) to provide certificates:

```bash
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v0.13.0/cert-manager.yaml
kubectl apply -f letsencrypt.yaml 
```

With all this infrastructure in place we can deploy a sample application:

```bash
kubectl create deployment hello-node --image=gcr.io/hello-minikube-zero-install/hello-node
kubectl expose deployment hello-node --port=8080
kubectl apply -f ingress.yaml
```

Now we can access our application:

```bash
curl -v https://hello-node.apps.icteam.be
```

Here are some useful commands to help with debugging:

```bash
# get some cluster info
kubectl cluster-info
kubectl proxy

# follow logs of the ingress controller
kubectl logs -n ingress-nginx deployment/nginx-ingress-controller -f

# restart the ingress controller
kubectl scale deployment -n ingress-nginx --replicas=0 nginx-ingress-controller
kubectl scale deployment -n ingress-nginx --replicas=1 nginx-ingress-controller
```

Remove the hello-node application (pods/deployment/service/ingress):

```bash
kubectl delete all -l app=hello-node
```

Finally you want to remove everything:

```bash
terraform destroy -auto-approve
```





