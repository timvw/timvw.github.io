---
title: Leverage Terraform, NGINX Ingress Controller, cert-manager and Let's Encrypt to quickly create a Kubernetes cluster on AWS.
author: timvw
layout: post
---
In my previous post I demonstrated how easy it has become to deploy a webapplications with an HTTPS backend on Kubernetes and Azure. In this post I demonstrate the same but on AWS.

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
    * On EKS the Kubernetes master runs in a different network and you need to provision such that the [nodegroups](https://docs.aws.amazon.com/eks/latest/userguide/managed-node-groups.html) can connect to this master. In my example this is achieved by installing an internet gateway.