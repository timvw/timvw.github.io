---
title: Configuring Grafana OAuth with Authentik
date: 2025-03-19
tags: ["grafana", "authentik", "oauth", "terraform", "kubernetes"]
categories: ["devops", "infrastructure"]
---

## Introduction

Following our previous posts about [setting up Authentik with Kubernetes and FluxCD](/2025/03/17/setting-up-authentik-with-kubernetes-and-fluxcd/) and [managing Authentik with Terraform](/2025/03/18/managing-authentik-with-terraform/), today we'll demonstrate how to implement OAuth authentication for Grafana using Authentik as the identity provider. This integration offers several benefits:

- Centralized user management with single sign-on (SSO)
- Role-based access control for Grafana using Authentik groups
- Secure authentication without the need to maintain separate user databases
- Consistent user experience across services

## Infrastructure Overview

Our setup consists of:

1. Authentik deployed on Kubernetes using FluxCD (as described in our first post)
2. Authentik configuration managed via Terraform (as explained in our second post)
3. Grafana deployed on Kubernetes using a Helm chart via FluxCD
4. OAuth integration between Grafana and Authentik

## Configuring Authentik for Grafana OAuth

First, let's look at how we've configured the Authentik side of the integration using Terraform.

### Authentik Provider and Application Configuration

Here's our Terraform configuration for the Grafana OAuth provider:

```terraform
variable "grafana_client_secret" {
  description = "Client secret for Grafana OAuth provider"
  type        = string
  sensitive   = true
}

data "authentik_flow" "default_invalidation_flow" {
  slug = "default-invalidation-flow"
}

data "authentik_flow" "default-provider-authorization-implicit-consent" {
  slug = "default-provider-authorization-implicit-consent"
}

data "authentik_certificate_key_pair" "default" {
  name = "authentik Self-signed Certificate"
}

data "authentik_property_mapping_provider_scope" "scope-email" {
  name = "scope_email"
}

data "authentik_property_mapping_provider_scope" "scope-profile" {
  name = "scope_profile"
}

data "authentik_property_mapping_provider_scope" "scope-openid" {
  name = "scope_openid"
}

resource "authentik_provider_oauth2" "grafana" {
  name               = "Grafana"
  client_id          = "grafana"
  client_secret      = var.grafana_client_secret
  authorization_flow = data.authentik_flow.default-provider-authorization-implicit-consent.id
  invalidation_flow  = data.authentik_flow.default_invalidation_flow.id
  signing_key        = data.authentik_certificate_key_pair.default.id

  property_mappings = [
    data.authentik_property_mapping_provider_scope.scope-email.id,
    data.authentik_property_mapping_provider_scope.scope-profile.id,
    data.authentik_property_mapping_provider_scope.scope-openid.id,
  ]

  allowed_redirect_uris = [
    {
      "matching_mode" = "strict"
      "url"           = "https://grafana.apps.timvw.be/login/generic_oauth"
    },
  ]
}

resource "authentik_application" "grafana" {
  name              = "Grafana"
  slug              = "grafana"
  protocol_provider = authentik_provider_oauth2.grafana.id
  meta_icon         = "https://www.svgrepo.com/download/448228/grafana.svg"
  meta_launch_url   = "https://grafana.apps.timvw.be/login/generic_oauth"
  open_in_new_tab   = true
}
```

This configuration:

1. Defines a variable for the client secret instead of hardcoding it
2. Creates an OAuth2 provider for Grafana with the necessary parameters
3. Sets up property mappings for the OpenID Connect scopes (email, profile, openid)
4. Configures the allowed redirect URI for Grafana's OAuth callback
5. Creates an application in Authentik that users will see in their dashboard

These data resources reference existing resources in Authentik that are created during installation rather than resources we need to create ourselves.

### Role-Based Access Control

To implement role-based access control for Grafana, we've set up specific groups:

```terraform
resource "authentik_group" "grafana_admins" {
  name         = "Grafana Admins"
  is_superuser = false
}

resource "authentik_group" "grafana_editors" {
  name         = "Grafana Editors"
  is_superuser = false
}

resource "authentik_policy_binding" "grafana_access" {
  target = authentik_application.grafana.uuid
  group  = authentik_group.grafana_admins.id
  order  = 0
}
```

This sets up two groups:
- **Grafana Admins**: Users with administrative privileges
- **Grafana Editors**: Users who can edit dashboards but have limited permissions

The policy binding ensures that members of the Grafana Admins group have access to the application.

### Secret Management

For security, we expose the client secret as a Terraform output, which can be consumed by other systems:

```terraform
output "grafana_client_secret" {
  value     = authentik_provider_oauth2.grafana.client_secret
  sensitive = true
}
```

## Configuring Grafana for OAuth Authentication

Now, let's examine the Grafana side of the setup, which is defined in our Kubernetes manifests:

```yaml
apiVersion: helm.toolkit.fluxcd.io/v2
kind: HelmRelease
metadata:
  name: grafana
  namespace: grafana
spec:
  interval: 10m
  timeout: 5m
  chart:
    spec:
      chart: grafana
      reconcileStrategy: ChartVersion
      sourceRef:
        kind: HelmRepository
        name: grafana
      version: '*'
  values:
    assertNoLeakedSecrets: false
    envFromSecret: grafana-oauth-credentials
    ingress:
      enabled: true
      annotations:
        cert-manager.io/cluster-issuer: "letsencrypt-prod"
      tls:
      - hosts:
        - grafana.apps.timvw.be
        secretName: grafana-apps-tls-secret        
      hosts:
        - grafana.apps.timvw.be
    datasources:
      datasources.yaml:
        apiVersion: 1
        datasources:
        - name: Jaeger
          ...
        - name: Prometheus
          ...
    grafana.ini:
      server:
        root_url: "https://grafana.apps.timvw.be"
      auth:
        signout_redirect_url: "https://authentik.apps.timvw.be/application/o/end-session/"
        oauth_auto_login: false
      auth.generic_oauth:
        name: Authentik
        enabled: true
        allow_sign_up: true
        client_id: grafana
        client_secret: ${CLIENT_SECRET}
        scopes: "openid profile email"
        auth_url: "https://authentik.apps.timvw.be/application/o/authorize/"
        token_url: "https://authentik.apps.timvw.be/application/o/token/"
        api_url: "https://authentik.apps.timvw.be/application/o/userinfo/"
        role_attribute_path: "contains(groups, 'Grafana Admins') && 'Admin' || contains(groups, 'Grafana Editors') && 'Editor' || 'Viewer'"
        use_pkce: true
      users:
        allow_sign_up: false
        auto_assign_org: true
        auto_assign_org_id: 1
```

The key parts of this configuration are:

1. **Reference to Secret**: The `envFromSecret: grafana-oauth-credentials` setting tells Grafana to load environment variables from a Kubernetes Secret, which includes the OAuth client secret.

2. **Authentication Settings**: The `auth` section configures the sign-out redirect URL, pointing back to Authentik's end-session endpoint.

3. **OAuth Configuration**: The `auth.generic_oauth` section contains the core OAuth configuration:
   - The auth, token, and API URLs point to Authentik's OAuth endpoints
   - The client_id matches the one defined in Authentik
   - The client_secret is loaded from the environment variables
   - The required scopes are specified (openid profile email)
   - PKCE (Proof Key for Code Exchange) is enabled for additional security

4. **Role Mapping**: The `role_attribute_path` setting contains a JMESPath expression that maps Authentik groups to Grafana roles:
   - Members of 'Grafana Admins' get the Admin role
   - Members of 'Grafana Editors' get the Editor role
   - All other users get the Viewer role

## Creating the Secret for OAuth Credentials

For the integration to work, we need to create a Kubernetes Secret containing the OAuth client secret:

```bash
# Get the client secret from Terraform output
CLIENT_SECRET=$(terraform output -raw grafana_client_secret)

# Create the Kubernetes Secret
kubectl create secret generic grafana-oauth-credentials \
  --namespace grafana \
  --from-literal=CLIENT_SECRET="$CLIENT_SECRET"
```

In practice, this would be part of a CI/CD pipeline or another automated process.

## Testing the Integration

After deploying these configurations, we can verify the integration by:

1. Accessing Grafana at https://grafana.apps.timvw.be
2. Clicking on the "Sign in with Authentik" button
3. Being redirected to Authentik's login page
4. After authentication, being redirected back to Grafana with the appropriate permissions

## Security Considerations

When implementing OAuth with Grafana and Authentik, we've taken several security measures:

1. **Use of PKCE**: The `use_pkce: true` setting enables Proof Key for Code Exchange, which prevents authorization code interception attacks.

2. **Secure Storage of Secrets**: Client secrets are stored in Kubernetes Secrets and injected into Grafana at runtime.

3. **Restricted Redirect URIs**: In Authentik, we've explicitly listed the allowed redirect URIs to prevent open redirector vulnerabilities.

4. **TLS Everywhere**: All communications between components use TLS encryption.

5. **Principle of Least Privilege**: Users are assigned the minimum necessary permissions based on their group membership.

## Conclusion

By integrating Grafana with Authentik using OAuth, we've established a robust authentication system that provides:

- Single sign-on for users across multiple applications
- Centralized user and permission management
- Role-based access control that's easy to adjust
- Improved security through modern authentication protocols

This setup builds on the foundation laid in our previous posts about Authentik deployment and Terraform management, completing a comprehensive identity management solution for our Kubernetes-based infrastructure.

The combination of GitOps with FluxCD and Infrastructure as Code with Terraform provides a fully declarative approach to both the deployment and configuration of this authentication infrastructure, making it reproducible, version-controlled, and easily maintainable.

## Resources

- [Authentik Grafana Integration Documentation](https://docs.goauthentik.io/integrations/services/grafana/)
- [Grafana OAuth Configuration Documentation](https://grafana.com/docs/grafana/latest/setup-grafana/configure-security/configure-authentication/generic-oauth/)
- [OAuth 2.0 with PKCE Explained](https://oauth.net/2/pkce/)