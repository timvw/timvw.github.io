---
title: Implementing Domain-Level Forward Authentication with Authentik
date: 2025-03-22
tags: ["authentik", "kubernetes", "nginx", "forward-auth", "terraform", "security"]
categories: ["devops", "infrastructure"]
---

## Introduction

In my previous posts on Authentik, I've covered [setting up the platform](/2025/03/17/setting-up-authentik-with-kubernetes-and-fluxcd/), [managing it with Terraform](/2025/03/18/managing-authentik-with-terraform/), and integrating it with services like [Grafana](/2025/03/19/configuring-grafana-oauth-with-authentik/), [MinIO](/2025/03/20/configuring-minio-oauth-with-authentik/), and [AWS IAM Identity Center](/2025/03/21/configuring-aws-identity-center-with-authentik-scim/).

Today, I'll explain how I implemented domain-level forward authentication to protect multiple applications in my Kubernetes cluster using Authentik's forward auth provider and NGINX ingress controller.

## Understanding Forward Authentication

Forward authentication is a pattern where a proxy (like NGINX) delegates the authentication decision to an external service (in our case, Authentik). This approach allows you to protect multiple applications without modifying their code or configurations.

Authentik offers two forward auth modes:

1. **Forward domain mode**: Authenticates at the domain level, allowing users to access all applications on the same domain after a single login
2. **Forward single mode**: Authenticates each application separately, requiring explicit authorization for each

For my cluster, I chose the domain-level approach as it provides a smoother user experience while still maintaining security.

## Configuring Authentik with Terraform

Let's start by examining my Terraform configuration for Authentik's forward auth provider:

```terraform
# https://docs.goauthentik.io/docs/add-secure-apps/outposts/embedded/

resource "authentik_outpost" "embedded" {
  name = "authentik Embedded Outpost"
  type = "proxy"
  protocol_providers = [
    authentik_provider_proxy.nginx_forward_auth.id
  ]
  service_connection = "403a40bd-821a-4a5b-9a89-ba3938e1fa8e"
}

resource "authentik_provider_proxy" "nginx_forward_auth" {
  name               = "nginx-forward-auth"
  external_host      = "https://authentik.apps.timvw.be"
  authorization_flow = data.authentik_flow.default_authorization_flow.id
  invalidation_flow  = data.authentik_flow.default_invalidation_flow.id

  # Allow all domains in your cluster to use this provider
  cookie_domain = ".apps.timvw.be"

  # Security settings
  mode            = "forward_domain"
  skip_path_regex = "^/(api|outpost\\.goauthentik\\.io)/.*$"
}

resource "authentik_application" "forward_auth" {
  name              = "Forward Authentication"
  slug              = "forward-auth"
  protocol_provider = authentik_provider_proxy.nginx_forward_auth.id
  meta_description  = "Forward Authentication for NGINX Ingress"
  meta_launch_url   = "blank://blank"
  lifecycle {
    ignore_changes = [
      meta_icon,
    ]
  }
}
```

There are a few important components to note:

1. **Embedded Outpost**: This is a component that runs inside Authentik and handles the forward authentication requests
2. **Proxy Provider**: This configures how authentication works, including:
   - `mode = "forward_domain"`: Users only need to authenticate once per domain
   - `cookie_domain = ".apps.timvw.be"`: Share authentication across all subdomains
   - `skip_path_regex`: Paths that bypass authentication, like API endpoints
3. **Application**: This defines the application in Authentik's UI

### Importing the Embedded Outpost

A challenge I faced was that the embedded outpost already exists within Authentik, but Terraform doesn't know about it. To manage it with Terraform, I needed to import the existing resource.

The Authentik Terraform provider had an issue (#341) where finding the correct IDs for the embedded outpost was difficult. To resolve this, I monitored network requests in Chrome Developer Tools while navigating to the outposts section in the Authentik admin interface. This allowed me to find:

1. The outpost ID (`pk`): `8e7ee1c7-e3d1-4198-aa41-a6b60bf0e2db`
2. The service connection object ID (`service_connection_obj.pk`): `403a40bd-821a-4a5b-9a89-ba3938e1fa8e`

In my Terraform code, I used these IDs to import the existing resource:

```terraform
import {
 id = "8e7ee1c7-e3d1-4198-aa41-a6b60bf0e2db"
 to = authentik_outpost.embedded
}
```

## Configuring NGINX Ingress Controller

With Authentik configured, the next step was to set up NGINX ingress to use forward authentication. Here's an example from my Jaeger deployment:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: jaeger
  namespace: monitoring
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
    # Authentik forward authentication
    kubernetes.io/ingress.class: public
    nginx.ingress.kubernetes.io/auth-url: http://authentik-server.authentik.svc.cluster.local/outpost.goauthentik.io/auth/nginx
    nginx.ingress.kubernetes.io/auth-signin: https://authentik.apps.timvw.be/outpost.goauthentik.io/start?rd=$scheme://$http_host$escaped_request_uri
    nginx.ingress.kubernetes.io/auth-response-headers: Set-Cookie,X-authentik-username,X-authentik-groups,X-authentik-email,X-authentik-name,X-authentik-uid
    nginx.ingress.kubernetes.io/auth-snippet: |
      proxy_set_header X-Forwarded-Host $http_host;
spec:
  tls:
  - hosts:
    - jaeger.apps.timvw.be
    secretName: jaeger-apps-tls-secret
  rules:
  - host: jaeger.apps.timvw.be
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: jaeger
            port:
              number: 16686
```

The key annotations are:

1. `nginx.ingress.kubernetes.io/auth-url`: Points to the Authentik service within the cluster
2. `nginx.ingress.kubernetes.io/auth-signin`: The URL for users to sign in (redirects here when unauthenticated)
3. `nginx.ingress.kubernetes.io/auth-response-headers`: Headers to pass from Authentik to the protected application
4. `nginx.ingress.kubernetes.io/auth-snippet`: Additional NGINX configuration, ensuring proper forwarding of host headers

## How Forward Authentication Works

With this configuration in place, here's the authentication flow:

1. User attempts to access a protected application (e.g., `jaeger.apps.timvw.be`)
2. NGINX intercepts the request and forwards it to Authentik via the auth-url
3. Authentik checks if the user is authenticated:
   - If authenticated, it returns a 200 response and NGINX allows the request to proceed
   - If not authenticated, Authentik returns a 401, and NGINX redirects to the auth-signin URL
4. After successful authentication at Authentik, the user is redirected back to the original URL
5. Since they're now authenticated for the domain, all subsequent requests to *.apps.timvw.be are allowed

## Advantages of Domain-Level Authentication

This approach offers several benefits:

1. **Single sign-on experience**: Users authenticate once and can access all protected applications
2. **Centralized access control**: All authorization decisions happen in Authentik
3. **Minimal application changes**: Applications don't need built-in authentication support
4. **Consistent user experience**: Same login flow for all applications
5. **Enhanced security**: Applications are never directly exposed without authentication

## Controlling Access to Applications

While domain-level authentication means a user can access all protected applications after logging in once, you might want to restrict certain applications to specific users or groups. Authentik handles this through its application permissions system:

1. Create a group in Authentik (e.g., "Jaeger Users")
2. Set the Forward Authentication application to require membership in this group
3. Only users in the specified group will be authorized to access the protected applications

## Creating Application Shortcuts

In addition to protecting applications with forward authentication, I also wanted to provide users with easy access to these applications through the Authentik dashboard. To do this, I created application shortcuts:

```terraform
resource "authentik_application" "jaeger" {
  name            = "Jaeger"
  slug            = "jaeger"
  meta_icon       = "https://raw.githubusercontent.com/jaegertracing/artwork/refs/heads/master/SVG/Jaeger_Logo_Final_PANTONE.svg"
  meta_launch_url = "https://jaeger.apps.timvw.be"
  open_in_new_tab = true
}
```

This creates a tile in the Authentik application portal that users can click to access Jaeger directly. The important aspects of this configuration are:

- `meta_launch_url`: Links to the protected application
- `meta_icon`: Provides a visual icon for the application
- `open_in_new_tab`: Opens the application in a new browser tab

## Troubleshooting Forward Authentication

When implementing this solution, I encountered a few issues worth mentioning:

1. **Cookie Issues**: Ensure your `cookie_domain` is correctly set to cover all applications
2. **Redirect Problems**: Check that the `auth-signin` URL correctly encodes the return URL
3. **Header Passing**: If applications need user information, verify that `auth-response-headers` includes all necessary headers
4. **Path Exclusions**: Adjust `skip_path_regex` if certain paths should bypass authentication (like health checks or API endpoints)

## Conclusion

Implementing domain-level forward authentication with Authentik and NGINX ingress provides a robust, centralized authentication layer for all applications in my Kubernetes cluster. With minimal configuration, I've secured multiple services while providing a seamless experience for users.

The combination of Authentik's flexible authentication capabilities and NGINX's ingress features makes this approach powerful yet simple to implement. Using Terraform to manage the configuration ensures the setup is reproducible and can be version-controlled.

This integration completes my series on Authentik implementations, demonstrating how a single identity provider can secure various aspects of your infrastructure, from cloud services to internal applications.

## Resources

- [Authentik Forward Auth Documentation](https://docs.goauthentik.io/docs/add-secure-apps/providers/proxy/forward_auth)
- [NGINX Ingress External Auth](https://kubernetes.github.io/ingress-nginx/examples/auth/external-auth/)
- [Authentik Embedded Outposts](https://docs.goauthentik.io/docs/add-secure-apps/outposts/embedded/)
- [Terraform Provider for Authentik](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs)