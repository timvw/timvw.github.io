---
date: 2021-01-20
title: Notes on microk8s and cert-manager
---
Last couple of weeks I've been using [MicroK8s](https://microk8s.io/) for local development.

Installing current version of [cert-manager](https://cert-manager.io/docs/) just worked by following the [installation instructions](https://cert-manager.io/docs/installation/kubernetes/):
```bash
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.2.0/cert-manager.yaml
```

Then I enabled the [ingress addon](https://microk8s.io/docs/addon-ingress):

```bash
microk8s.enable ingress
```

 Configuring [Let's Encrypt](https://letsencrypt.org/) required some deviations from the [documentation](https://cert-manager.io/docs/configuration/acme/). Only resources of type ClusterIssuer and public as ingress class seem to work:
 
```yml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
spec:
  acme:
    email: tim@timvw.be
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-staging
    solvers:
    - http01:
        ingress:
          class: public
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: tim@timvw.be
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: public 
```

When using nginx as ingress class I ran into various errors:
- challenge propagation: wrong status code '404', expected '200'
- certificate never becoming 'Ready'
- ...

Here are some helpful commands:
```bash
kubectl logs -f -n cert-manager -f app=cert-manager
kubectl get ingress
```

Then I noticed that acme-staging-v02.api.letsencrypt.org could not be resolved by the cert-manager pods (trying to resolve from 127.0.0.1:53), thus I also enabled the dns addon and restarted the pods (by deleting them)

```bash
microk8s.enable dns
kubectl delete pod -n cert-manager -l app=cert-manager
```

And then all was fine. Eg: [https://strava.apps.timvw.be](https://strava.apps.timvw.be) just works :)
