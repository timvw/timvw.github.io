---
date: 2021-01-05
title: cluster-info on k8s cluster with limited permissions
---

When you have limited access (eg: only a specific [namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) (~ [openshift project](https://docs.openshift.com/enterprise/3.0/architecture/core_concepts/projects_and_users.html#:~:text=A%20Kubernetes%20namespace%20provides%20a,provide%20a%20unique%20scope%20for%3A&text=The%20ability%20to%20limit%20community%20resource%20consumption.)) on a kubernetes cluster you may not be able to run kubectl cluster-info.

```bash
➜  ~ kubectl cluster-info

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
Error from server (Forbidden): services is forbidden: User "timvw" cannot list resource "services" in API group "" in the namespace "kube-system"
```

As soon as you run the command in your namespace  it will work:

```bash
➜  ~ kubectl cluster-info -n spark
Kubernetes master is running at https://api.customer.example:443

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```
