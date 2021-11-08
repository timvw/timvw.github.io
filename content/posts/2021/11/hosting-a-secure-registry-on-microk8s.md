---
date: 2021-11-08
title: Hosting a secure registry on microk8s
---
The documentation for microk8s seems to suggest that there is a built-in registry that can be used, but not in a secure way.

In essence, you need to [configure](https://docs.docker.com/registry/configuration) the following:

* Storage

For storage I will assume that the local filesystem is sufficient (or that you have a safety net, such as NFS backing it up, in place).

* Authentication

For authentication I use create a secret which contains a htpasswd file, here is how you can generate this:

```bash
docker run --rm --entrypoint htpasswd registry:2.6.2 -Bbn username password > ./registry-htpasswd
kubectl create secret generic auth-secret --from-file=./registry-htpasswd -n registry
```

* A TLS certificate

The TLS certificate is generated using [cert-manager]. See this [post] on how to achieve that.

When all is in place you can simply kubectl apply the following:

```yml
apiVersion: v1
kind: Namespace
metadata:
  name: registry
  labels:
    app: registry
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: registry
  namespace: registry
  labels:
    app: registry
spec:
  replicas: 1
  selector:
    matchLabels:
      app: registry
  template:
    metadata:
      labels:
        app: registry
    spec:
      containers:
      - name: registry
        image: registry:2.6.2
        ports:
        - containerPort: 5000
        volumeMounts:
        - name: repo-vol
          mountPath: "/var/lib/registry"
        - name: certs-vol
          mountPath: "/certs"
          readOnly: true
        - name: auth-vol
          mountPath: "/auth"
          readOnly: true
        env:
        - name: REGISTRY_AUTH
          value: "htpasswd"
        - name: REGISTRY_AUTH_HTPASSWD_REALM
          value: "Registry Realm"
        - name: REGISTRY_AUTH_HTPASSWD_PATH
          value: "/auth/registry-htpasswd"
        - name: REGISTRY_HTTP_TLS_CERTIFICATE
          value: "/certs/tls.crt"
        - name: REGISTRY_HTTP_TLS_KEY
          value: "/certs/tls.key"
      volumes:
      - name: repo-vol
        hostPath:
          # directory location on host
          path: /home/timvw/registry
          # this field is optional
          type: Directory
      - name: certs-vol
        secret:
          secretName: registry-tls-secret
      - name: auth-vol
        secret:
          secretName: auth-secret
---
apiVersion: v1
kind: Service
metadata:
  name: docker-registry
  namespace: registry
spec:
  selector:
    app: registry
  ports:
  - port: 5000
    targetPort: 5000
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: registry
  namespace: registry
  labels:
    app: registry
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
    nginx.ingress.kubernetes.io/proxy-body-size: 1024m
spec:
  tls:
  - hosts:
    - registry.apps.timvw.be
    secretName: registry-tls-secret
  rules:
  - host: registry.apps.timvw.be
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: docker-registry
            port:
              number: 5000   
```

Once everything is in place you can test the registry by running:

```bash
docker login registry.apps.timvw.be
```

In order to use this registry in your cluster you need to have a [secret](https://kubernetes.io/docs/concepts/configuration/secret/) in the namespace where the pods are created with the following:

```bash
kubectl create secret docker-registry regcred -n demo \
  --docker-server=registry.apps.timvw.be \
  --docker-username=username \
  --docker-password=password \
  --docker-email=test@example.com
```

Now you can create a deployment using this secret and referencing images on the registry:

```yml
---
apiVersion: apps/v1
kind: Deployment
...
    spec:
      imagePullSecrets:
      - name: regcred     
      containers:      
      - name: demo
        image: registry.apps.timvw.be/demo:1.2.3 
...
```