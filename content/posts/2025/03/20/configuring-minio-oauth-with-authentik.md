---
title: Configuring MinIO OAuth with Authentik
date: 2025-03-20
tags: ["minio", "authentik", "oauth", "terraform", "kubernetes"]
categories: ["devops", "infrastructure"]
---

## Introduction

Following our previous posts about [setting up Authentik with Kubernetes and FluxCD](/2025/03/17/setting-up-authentik-with-kubernetes-and-fluxcd/), [managing Authentik with Terraform](/2025/03/18/managing-authentik-with-terraform/), and [configuring Grafana OAuth integration](/2025/03/19/configuring-grafana-oauth-with-authentik/), today I'll share how I implemented OAuth authentication for MinIO using Authentik as the identity provider.

MinIO is a high-performance object storage system compatible with Amazon S3 API. By integrating it with Authentik, we can leverage centralized authentication and role-based access control for our object storage environment.

## Integration Overview

The integration between MinIO and Authentik involves the following components:

1. **Authentik OAuth Provider**: Configuration in Authentik to enable OAuth authentication for MinIO
2. **Property Mappings**: Ensuring user group information is included in JWT tokens
3. **MinIO OpenID Configuration**: Setting up MinIO to use Authentik for authentication
4. **JWT Claims Processing**: How MinIO interprets group information from tokens

## Configuring Authentik for MinIO OAuth

First, let's look at how we've configured the Authentik side of the integration using Terraform:

```terraform
resource "authentik_provider_oauth2" "minio" {
  name               = "Minio"
  client_id          = "minio"
  client_secret      = var.minio_client_secret
  authorization_flow = data.authentik_flow.default-provider-authorization-implicit-consent.id
  invalidation_flow  = data.authentik_flow.default_invalidation_flow.id
  signing_key        = data.authentik_certificate_key_pair.default.id

  sub_mode = "user_username"

  property_mappings = [
    data.authentik_property_mapping_provider_scope.scope-email.id,
    data.authentik_property_mapping_provider_scope.scope-profile.id,
    data.authentik_property_mapping_provider_scope.scope-openid.id,
    authentik_property_mapping_provider_scope.minio.id,
  ]

  allowed_redirect_uris = [
    {
      "matching_mode" = "strict"
      "url"           = "https://minio.apps.timvw.be/oauth_callback"
    },
  ]
}

resource "authentik_application" "minio" {
  name              = "Minio"
  slug              = "minio"
  protocol_provider = authentik_provider_oauth2.minio.id
  meta_icon         = "https://dl.min.io/logo/Minio_logo_light/Minio_logo_light.svg"
  meta_launch_url   = "https://minio.apps.timvw.be"
  open_in_new_tab   = true
}

resource "authentik_property_mapping_provider_scope" "minio" {
  name       = "minio"
  scope_name = "minio"
  expression = <<EOF
return {
  "policy": "readwrite",
}
EOF
}
```

This configuration:
1. Creates an OAuth2 provider for MinIO with the necessary flow and key settings
2. Includes standard OpenID scopes plus a custom scope for MinIO
3. Sets up allowed redirect URIs for security
4. Creates an application in Authentik that users will see in their dashboard
5. Defines a custom property mapping that adds a policy claim to the JWT

## Configuring MinIO for OpenID Authentication

Now let's look at the MinIO configuration in our Kubernetes deployment:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: minio
  namespace: minio
spec:
  replicas: 1
  selector:
    matchLabels:
      app: minio
  template:
    metadata:
      labels:
        app: minio
    spec:
      containers:
      - name: minio
        image: minio/minio
        args:
        - server
        - --address
        - :9000
        - --console-address
        - :9001
        - /data
        env:
        - name: MINIO_ROOT_USER
          valueFrom:
            secretKeyRef:
              name: minio-credentials
              key: root-user
        - name: MINIO_ROOT_PASSWORD
          valueFrom:
            secretKeyRef:
              name: minio-credentials
              key: root-password
        # https://min.io/docs/minio/linux/operations/external-iam/configure-openid-external-identity-management.html
        - name: MINIO_IDENTITY_OPENID_CONFIG_URL
          value: "https://authentik.apps.timvw.be/application/o/minio/.well-known/openid-configuration"
        - name: MINIO_IDENTITY_OPENID_CLIENT_ID
          value: minio
        - name: MINIO_IDENTITY_OPENID_CLIENT_SECRET
          value: ${CLIENT_SECRET}
        - name: MINIO_IDENTITY_OPENID_DISPLAY_NAME
          value: "Authentik (timvw.be)"
        - name: MINIO_IDENTITY_OPENID_REDIRECT_URI
          value: "https://minio.apps.timvw.be/oauth_callback"
        # Additional configuration omitted for brevity
```

The key parts of this configuration are:

1. **OpenID Configuration URL**: Points to Authentik's well-known OpenID configuration endpoint for the MinIO application
2. **Client Credentials**: The client ID and secret matching those set up in Authentik
3. **Display Name**: A friendly name for the login button in the MinIO console
4. **Redirect URI**: Matches the URI allowed in the Authentik OAuth provider configuration

## How MinIO OpenID Authentication Works

MinIO supports OpenID Connect (OIDC) for authentication, which allows it to delegate user authentication to Authentik. When properly configured, the authentication flow works as follows:

1. User attempts to access MinIO and clicks "Log in with OpenID"
2. User is redirected to Authentik's login page
3. After successful authentication, Authentik generates a JWT token containing user information
4. User is redirected back to MinIO with this token
5. MinIO validates the token and extracts user information, including group memberships
6. MinIO maps the user's groups to policies that control their access permissions

## Understanding the Property Mapping

A key part of this integration is the property mapping we've defined in Authentik. Let's examine our Terraform configuration more closely:

```terraform
resource "authentik_property_mapping_provider_scope" "minio" {
  name       = "minio"
  scope_name = "minio"
  expression = <<EOF
return {
  "policy": "readwrite",
}
EOF
}
```

This property mapping adds a "policy" claim to the JWT token with the value "readwrite". When MinIO receives this token, it will apply the corresponding policy to the authenticated user.

MinIO uses these policies to control what actions users can perform:

- **consoleAdmin**: Grants full administrative access
- **readOnly**: Grants read-only access to all buckets
- **readwrite**: Grants read and write access but not administrative privileges
- **writeonly**: Grants write-only access (can upload but not view files)

You can also create custom policies for more fine-grained permission control if needed.

## Configuring for Security

When implementing this integration, several security considerations are important:

1. Using short-lived access tokens (typically 1 hour)
2. Storing client secrets securely in Kubernetes Secrets
3. Restricting allowed redirect URIs to prevent open redirector vulnerabilities
4. Using HTTPS for all communications between Authentik and MinIO
5. Applying the principle of least privilege for access control

## Testing the Integration

After deploying the integration, you can verify it by:

1. Accessing your MinIO instance
2. Clicking the "Log in with OpenID" button
3. Successfully authenticating with Authentik
4. Being redirected back to MinIO with the appropriate permissions

If you encounter issues, check:
- The JWT token contents (using browser developer tools)
- MinIO server logs for authentication-related messages
- Authentik logs for token generation issues

## Conclusion

Integrating MinIO with Authentik provides a robust OAuth authentication solution that centralizes user management and enables role-based access control. This integration follows the same principles as our Grafana integration, creating a consistent authentication experience across our infrastructure.

By leveraging Authentik as our identity provider for both services, we eliminate the need to manage separate credentials for each application while improving overall security through centralized management.

## Resources

- [Authentik MinIO Integration Documentation](https://docs.goauthentik.io/integrations/services/minio/)
- [MinIO OpenID Configuration Documentation](https://min.io/docs/minio/linux/operations/external-iam/configure-openid-external-identity-management.html)
- [MinIO Policy Documentation](https://min.io/docs/minio/linux/administration/identity-access-management/policy-based-access-control.html)
- [JWT.io Debugger](https://jwt.io/) - Useful for debugging JWT tokens during integration