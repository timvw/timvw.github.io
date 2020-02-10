# Quickly setup a kubernetes cluster on azure with HTTPS ingress using letsencrypt for TLS.

## Configure the azure service principal for Terraform

```bash
export ARM_CLIENT_ID="XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
export ARM_CLIENT_SECRET="XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
export ARM_SUBSCRIPTION_ID="XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
export ARM_TENANT_ID="XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
```

## Configure Terraform variables

```bash
export TF_VAR_client_id=$ARM_CLIENT_ID
export TF_VAR_client_secret=$ARM_CLIENT_SECRET
export TF_VAR_aks_service_principal_app_id=$ARM_CLIENT_ID
export TF_VAR_aks_service_principal_client_secret=$ARM_CLIENT_SECRET
```

## Build the kubernetes cluster

```bash
terraform init
terraform apply -auto-approve
```

## Add entry to kube config

```bash
az aks get-credentials --resource-group k8s-test --name kaz
```

## Deploy nginx ingress controller

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.28.0/deploy/static/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.28.0/deploy/static/provider/cloud-generic.yaml
```

## Add A-record for public ip address of loadbalancer

As part of the nginx ingress controller also a loadbalancer with a public ip was created.
Here is how you can fetch that address:

```bash
# use homebrew gnu grep instead of mac vanilla grep to extract public ip address
az network public-ip list | ggrep -Po '(?<="ipAddress": ")([^"]*)'
```

Now add an A-record to a wildcard domain (in this example i use *.apps.icteam.be)


## Deploy cert manager

```bash
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v0.13.0/cert-manager.yaml
```

### Configure letsencrypt on cert manager

```bash
kubectl apply -f letsencrypt.yaml 
```

## Deploy sample application

```bash
kubectl create deployment hello-node --image=gcr.io/hello-minikube-zero-install/hello-node
kubectl expose deployment hello-node --port=8080
kubectl apply -f ingress.yaml
```

## Access the application over HTTPS

```bash
curl -v https://hello-node.apps.icteam.be
```

## Debugging commands

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
## Destroy everything

```bash
terraform destroy -auto-approve
```

Resources: 
* https://www.terraform.io/
* https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html
* https://www.hashicorp.com/blog/kubernetes-cluster-with-aks-and-terraform/
* https://kubernetes.github.io/ingress-nginx/deploy/
* https://kubernetes.github.io/ingress-nginx/deploy/#azure
* https://cert-manager.io/docs/installation/kubernetes/
* https://kubernetes.io/docs/tutorials/hello-minikube/





