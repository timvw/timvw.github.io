---
title: Setting up Authentik with Kubernetes and FluxCD
date: 2025-03-17
tags: ["kubernetes", "authentik", "gitops", "fluxcd", "security"]
categories: ["devops", "infrastructure"]
---

## Introduction to Authentik

[Authentik](https://goauthentik.io/) is a powerful open-source Identity Provider (IdP) that allows centralized management of user authentication, authorization, and single sign-on. In this post, I'll walk through how I've set up Authentik in my Kubernetes cluster using FluxCD for GitOps-driven deployment.

## Infrastructure Overview

I'm using a GitOps approach with FluxCD to manage my Kubernetes infrastructure. The configuration is maintained in a Git repository, ensuring that my entire setup is declarative and version-controlled.

The Authentik deployment consists of:
- Namespace definition
- Helm repository reference
- HelmRelease configuration with secret management

## Setting Up the Namespace and Helm Repository

First, I created a dedicated namespace for Authentik and configured the Helm repository:

```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: authentik
  labels:
    app: authentik
---
apiVersion: source.toolkit.fluxcd.io/v1
kind: HelmRepository
metadata:
  name: authentik
  namespace: authentik
spec:
  interval: 5m0s
  provider: generic
  url: https://charts.goauthentik.io
```

## Configuring the HelmRelease

Next is the HelmRelease configuration which defines how Authentik is deployed:

```yaml
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
  name: authentik
  namespace: authentik
spec:
  chart:
    spec:
      chart: authentik
      reconcileStrategy: ChartVersion
      sourceRef:
        kind: HelmRepository
        name: authentik
      version: '*'
  interval: 5m0s
  timeout: 5m
  valuesFrom:
    - kind: Secret
      name: authentik-credentials
      valuesKey: secret-key
      targetPath: authentik.secret_key
      optional: false
    - kind: Secret
      name: authentik-credentials
      valuesKey: postgresql-password
      targetPath: authentik.postgresql.password
      optional: false
  values:
    authentik:
      # This sends anonymous usage-data, stack traces on errors and
      # performance data to sentry.io, and is fully opt-in
      error_reporting:
          enabled: false 
      postgresql:
        host: postgresql.postgresql.svc.cluster.local
        port: 5432
        name: authentik
        user: authentik
      redis:
        host: redis.redis.svc.cluster.local
    server:
      replicas: 1
      ingress:
        enabled: true
        ingressClassName: public
        annotations:
          cert-manager.io/cluster-issuer: "letsencrypt-prod"
        tls:
          - secretName: authentik-tls
            hosts:
              - authentik.apps.timvw.be
        hosts:
          - authentik.apps.timvw.be
    worker:
      replicas: 1
```

## Managing Secrets Securely

One important aspect of the setup is separating sensitive information from the main configuration. I store credentials in a dedicated Secret:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: authentik-credentials
  namespace: authentik
type: Opaque
stringData:
  secret-key: "****"  # Authentik secret key (redacted)
  postgresql-password: "****"  # Database password (redacted)
```

## Using FluxCD's valuesFrom Feature

A key part of this setup is using FluxCD's `valuesFrom` feature, which allows us to inject values from Kubernetes Secrets into the Helm chart. This approach:

1. Keeps sensitive values out of the main configuration
2. Follows the principle of least privilege
3. Makes it easier to rotate credentials
4. Improves the security of the GitOps workflow

In the HelmRelease above, you can see how I reference specific Secret keys and inject them into the chart's values structure at the appropriate paths:

```yaml
valuesFrom:
  - kind: Secret
    name: authentik-credentials
    valuesKey: secret-key
    targetPath: authentik.secret_key
  - kind: Secret
    name: authentik-credentials
    valuesKey: postgresql-password
    targetPath: authentik.postgresql.password
```

## Database Integration

Authentik needs a PostgreSQL database, which I've previously deployed in my cluster. The configuration references this existing database:

```yaml
postgresql:
  host: postgresql.postgresql.svc.cluster.local
  port: 5432
  name: authentik
  user: authentik
```

### Setting Up the PostgreSQL Database and User

Before deploying Authentik, you need to set up a PostgreSQL database and user. Here's how I prepared the database:

1. First, connect to your PostgreSQL server. If you're running PostgreSQL in Kubernetes, you can use port-forwarding or connect to the pod directly:

```bash
# Port-forward the PostgreSQL service to your local machine
kubectl port-forward -n postgresql svc/postgresql 5432:5432

# Or connect directly to the PostgreSQL pod
kubectl exec -it -n postgresql $(kubectl get pods -n postgresql -l app=postgresql -o name | head -n 1) -- bash
```

2. Once connected, run the following SQL commands to create the necessary database, user, and extensions:

```sql
-- Create a new user for Authentik with a strong password
CREATE USER authentik WITH PASSWORD 'your-strong-password-here';

-- Create a dedicated database for Authentik
CREATE DATABASE authentik;

-- Grant all privileges on the database to the authentik user
GRANT ALL PRIVILEGES ON DATABASE authentik TO authentik;

-- Connect to the authentik database
\c authentik

-- Enable needed extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "citext";
```

3. After setting up the database, create a Kubernetes Secret to store the credentials:

```bash
# Create a secret with the PostgreSQL password and a random secret key for Authentik
kubectl create secret generic authentik-credentials \
  --namespace authentik \
  --from-literal=postgresql-password='your-strong-password-here' \
  --from-literal=secret-key='another-strong-random-key-for-authentik'
```

This secret is then referenced in the HelmRelease's `valuesFrom` section as shown earlier.

In a production environment, you might want to consider:

1. Using a managed PostgreSQL service for better reliability and scaling
2. Implementing database backups and monitoring
3. Using a more secure method for managing secrets (like External Secrets Operator, which we'll cover in a future post)
4. Automating the database setup process to make it reproducible

## Redis for Caching

Similarly, I'm using a Redis instance for caching:

```yaml
redis:
  host: redis.redis.svc.cluster.local
```

## Ingress Configuration

For external access, I've configured an Ingress resource with TLS:

```yaml
ingress:
  enabled: true
  ingressClassName: public
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
  tls:
    - secretName: authentik-tls
      hosts:
        - authentik.apps.timvw.be
  hosts:
    - authentik.apps.timvw.be
```

## Future Enhancements

In a future post, I'll explore how to enhance this setup by leveraging External Secrets Operator (ESO) with AWS Secrets Manager to provide a more robust and centralized secrets management solution. This approach would offer benefits like centralized secret management, better access control, automatic rotation, and improved auditability.

## Conclusion

Using Authentik with FluxCD provides a powerful, secure identity management solution that follows GitOps best practices. By separating sensitive information into Kubernetes Secrets and using FluxCD's `valuesFrom` feature, we maintain security while keeping our configuration declarative and version-controlled.

This approach can be applied to other applications requiring secure credential management, making it a valuable pattern for Kubernetes deployments.