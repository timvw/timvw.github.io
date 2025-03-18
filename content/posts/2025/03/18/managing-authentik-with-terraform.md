---
title: "Managing Authentik with Terraform"
date: 2025-03-18T12:00:00+01:00
draft: false
tags: ["terraform", "authentik", "identity", "infrastructure", "iac"]
categories: ["devops", "infrastructure"]
---

## Introduction

In my [previous post](/2025/03/17/setting-up-authentik-with-kubernetes-and-fluxcd/), I detailed how to deploy [Authentik](https://goauthentik.io/) on Kubernetes using FluxCD for GitOps-driven management. Today, I'll explore how to manage the configuration of your Authentik instance using Terraform, providing a complete infrastructure-as-code solution for your identity provider.

## Why Terraform for Authentik?

While deploying Authentik with Kubernetes and FluxCD gives us a solid foundation, we still need to configure the actual identity provider - creating applications, setting up OAuth providers, configuring authorization policies, and more. This is where Terraform comes in.

Using Terraform to manage Authentik configuration offers several benefits:

1. **Version-controlled configuration**: All changes to your identity infrastructure are tracked in Git
2. **Reproducibility**: You can recreate your entire identity setup in a new environment
3. **Automation**: Integrate identity management into your CI/CD pipelines
4. **Documentation as code**: Your Terraform code serves as documentation for your identity setup
5. **Consistency**: Ensure consistent configuration across environments

## The Authentik Terraform Provider

The [Authentik Terraform Provider](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs) allows you to manage your Authentik instance with infrastructure as code. Here's how to set it up:

```terraform
terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2024.12.0"
    }
  }
}

provider "authentik" {
  # Connection details are configured via environment variables
}
```

## Environment Variables Authentication

Rather than hardcoding credentials in your Terraform configuration (which would be a security risk), I use environment variables to authenticate with Authentik:

```bash
# Authentik configuration
AUTHENTIK_URL="https://authentik.apps.example.com/"
AUTHENTIK_TOKEN="your_api_token"
```

For convenience, I keep these in a `.env` file (which is not committed to version control) and source it before running Terraform commands:

```bash
source .env
terraform plan
```

## What Can You Manage with Terraform?

The [Authentik Terraform provider](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs) allows you to manage nearly all aspects of your Authentik configuration:

- **Applications**: Define the applications that users can access through Authentik
- **Providers**: Configure authentication providers (OAuth2, SAML, LDAP, etc.)
- **Sources**: Set up identity sources like social login providers
- **Flows**: Create and customize authentication flows
- **Policies**: Define access policies for applications and resources
- **Groups**: Manage user groups for access control
- **Stages**: Configure the various stages that make up authentication flows
- **Property Mappings**: Control how user attributes are mapped between systems

## Common Patterns

When working with Terraform and Authentik, I've found several useful patterns:

### Using Data Sources for Existing Resources

Often, you'll need to reference existing resources in Authentik. Data sources provide a way to reference these resources without managing them directly:

```terraform
data "authentik_flow" "default_authorization_flow" {
  slug = "default-provider-authorization-implicit-consent"
}

data "authentik_certificate_key_pair" "default" {
  name = "authentik Self-signed Certificate"
}
```

### Modular Configuration

As your Authentik configuration grows, it's helpful to organize your Terraform code into modular units. I typically structure my configuration with separate files for different functional areas:

- `provider.tf` - Provider configuration
- `variables.tf` - Input variables
- `applications.tf` - Application definitions
- `oauth_providers.tf` - OAuth2 provider configurations
- `access_control.tf` - Groups and policies
- `outputs.tf` - Outputs, like client secrets that need to be used elsewhere

## Coming Next

In upcoming posts, I'll dive deeper into specific use cases for Authentik with Terraform:

1. Setting up Google OAuth for social login
2. Configuring OAuth2 providers for applications like Grafana and MinIO
3. Implementing fine-grained access control with groups and policies
4. Creating custom property mappings for specialized needs

## Conclusion

Managing Authentik with Terraform completes the infrastructure-as-code story that we began with Kubernetes and FluxCD. Together, these tools provide a robust, reproducible approach to identity management that fits well into a modern DevOps workflow.

By treating your identity provider configuration as code, you gain all the benefits of version control, peer review, and automated deployment while maintaining tight control over your authentication and authorization infrastructure.

## Resources

- [Authentik Official Website](https://goauthentik.io/)
- [Authentik Terraform Provider Documentation](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs)
- [Terraform Documentation](https://www.terraform.io/docs/)