---
date: "2020-02-25T00:00:00Z"
title: Leverage Terraform, NGINX Ingress Controller, cert-manager and Let's Encrypt to quickly create a Kubernetes cluster on AWS.
aliases:
 - /2020/02/25/terraform-aws-k8s-nginx-letsencrypt/
 - /2020/02/25/terraform-aws-k8s-nginx-letsencrypt.html
---
In my [previous](https://timvw.be/2020/02/10/terraform-azure-k8s-nginx-letsencrypt.html) post I demonstrated how easy it has become to deploy a webapplications with an HTTPS backend on Kubernetes and Azure. In this post I demonstrate the same but on AWS.

In order to follow along you should clone the sample code from this [repository](https://github.com/timvw/sample-terraform-aws-k8s-nginx-letsencrypt):

```bash
git clone https://github.com/timvw/sample-terraform-aws-k8s-nginx-letsencrypt
```

First [configure the aws access_key and secret_key for Terraform](hhttps://www.terraform.io/docs/providers/aws/index.html):

```bash
export AWS_ACCESS_KEY="XXXXXXXXXXXXXXXXXX"
export AWS_SECRET_KEY="XXXXXXXXXXXXXXXXXX"
export AWS_DEFAULT_REGION="eu-west-1"
```

With all this configuration in place we can instruct Terraform to create the kubernetes cluster:

```bash
terraform init
terraform apply -auto-approve
```

After a couple (~15) of minutes your cluster will be ready. Importing the credentials into your ~/.kube/config can be done as following:

```bash
aws eks --region $AWS_DEFAULT_REGION update-kubeconfig --name demo
```

There are some differences with AKS:

* On AKS a client and key certificate are added to your kubeconfig. On EKS an entry is added which invokes aws eks get-token

* On EKS the Kubernetes master runs in a different network and you need to provision such that the [nodegroups](https://docs.aws.amazon.com/eks/latest/userguide/managed-node-groups.html) can connect to this master. In my example this is achieved by installing an [internet gateway](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html).

Another remark: In case you try to create a [Fargate profile](https://www.terraform.io/docs/providers/aws/r/eks_fargate_profile.html) and it fails you should verify that you are doing it in a [supported region](https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/).

Now it is time to [deploy the NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/). We also need to apply the [aws specific](https://kubernetes.github.io/ingress-nginx/deploy/#aws) additions:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.29.0/deploy/static/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.29.0/deploy/static/provider/aws/service-l4.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.29.0/deploy/static/provider/aws/patch-configmap-l4.yaml
```

Deploying the NGINX Ingress Controller results in the creation of a loadbalancer and a public ip. Here is how you can fetch that address:

```bash
aws elb describe-load-balancers | jq -r '.LoadBalancerDescriptions[].DNSName'
```

In this example we want to access our applications as https://XXX.aws.icteam.be.
We achieve this by adding an A-record (the azure public ip address) pointing to *.aws.icteam.be

For the HTTPS part we [install cert-manager](https://cert-manager.io/docs/installation/kubernetes/) and use [Let's Encrypt](https://letsencrypt.org/) to provide certificates:

```bash
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.13.0/cert-manager.yaml
kubectl apply -f letsencrypt.yaml
```

With all this infrastructure in place we can deploy a sample application:

```bash
kubectl create deployment hello-node --image=gcr.io/hello-minikube-zero-install/hello-node
kubectl expose deployment hello-node --port=8080
kubectl apply -f hello-node-ingress.yaml 
```

Or we can [deploy](https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html) and expose the kubernetes dashboard:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml
kubectl apply -f dashboard-sa.yaml
kubectl apply -f dashboard-ingress.yaml
```

You can fetch the token as following:

```bash
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
```