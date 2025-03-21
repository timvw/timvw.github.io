---
title: Configuring AWS Identity Center with Authentik SCIM Provisioning
date: 2025-03-21
tags: ["aws", "authentik", "scim", "terraform", "identity-center"]
categories: ["devops", "infrastructure"]
---

## Introduction

In previous posts, I've covered [setting up Authentik with Kubernetes and FluxCD](/2025/03/17/setting-up-authentik-with-kubernetes-and-fluxcd/), [managing Authentik with Terraform](/2025/03/18/managing-authentik-with-terraform/), and integrating it with various services like [Grafana](/2025/03/19/configuring-grafana-oauth-with-authentik/) and [MinIO](/2025/03/20/configuring-minio-oauth-with-authentik/). Today, I'll explain how I configured AWS IAM Identity Center (formerly AWS SSO) with Authentik using SCIM provisioning.

AWS IAM Identity Center has become a critical component for managing access to AWS accounts and applications. By integrating it with Authentik using SCIM (System for Cross-domain Identity Management), we can automate user provisioning and deprovisioning, centralize identity management, and implement consistent access controls across our AWS environment.

This post will focus specifically on the SCIM provisioning aspect and an important consideration I discovered: the relationship between SAML name_id_mapping and SCIM username fields.

## Integration Overview

The integration between Authentik and AWS IAM Identity Center involves:

1. **SAML Authentication**: AWS IAM Identity Center acts as a SAML Service Provider
2. **SCIM Provisioning**: Syncs users and groups from Authentik to AWS IAM Identity Center
3. **User Mapping**: Configuring how Authentik user attributes map to AWS IAM Identity Center
4. **Permission Sets**: Defining AWS permissions assigned to provisioned users

Let's dive into each component.

## Configuring AWS IAM Identity Center

First, we need to set up AWS IAM Identity Center. In the AWS Management Console:

1. Enable AWS IAM Identity Center
2. Under "Settings", choose "Identity source" and select "External identity provider"
3. Set up SAML authentication
4. Enable automatic provisioning using SCIM

After setting up the SAML provider, AWS generates:
- An IAM Identity provider ARN
- A SCIM endpoint URL
- A SCIM access token

We'll need these when configuring Authentik.

## Configuring Authentik with Terraform

Now, let's look at how I've configured Authentik for AWS IAM Identity Center using Terraform:

```terraform
# Authentik SAML Provider
resource "authentik_provider_saml" "aws" {
  name               = "AWS IAM Identity Center"
  authorization_flow = data.authentik_flow.default_authorization_flow.id
  invalidation_flow  = data.authentik_flow.default_invalidation_flow.id
  acs_url            = "https://eu-central-1.signin.aws.amazon.com/platform/saml/acs/e4f71ab4-31d3-46cd-a105-2c2c38ec0032"
  audience           = "https://eu-central-1.signin.aws.amazon.com/platform/saml/d-99677451d0"
  issuer             = "https://eu-central-1.signin.aws.amazon.com/platform/saml/d-99677451d0"
  signing_kp         = data.authentik_certificate_key_pair.default.id
  sp_binding         = "post"
  property_mappings  = []
  name_id_mapping    = data.authentik_property_mapping_provider_saml.username.id
}

# Authentik Application
resource "authentik_application" "aws" {
  name                  = "AWS Console (icteam)"
  slug                  = "aws-console-icteam"
  protocol_provider     = authentik_provider_saml.aws.id
  meta_icon             = "https://www.svgrepo.com/download/448266/aws.svg"
  meta_launch_url       = "https://icteam.awsapps.com/start"
  open_in_new_tab       = true
  backchannel_providers = [authentik_provider_scim.aws.id]
}

# Authentik SCIM Provider
resource "authentik_provider_scim" "aws" {
  name                          = "AWS IAM Identity Center SCIM"
  url                           = var.aws_scim_url
  token                         = var.aws_scim_token
  exclude_users_service_account = true
  filter_group                  = data.authentik_group.aws_users.id
  property_mappings = [
    resource.authentik_property_mapping_provider_scim.aws_scim_user_mapping.id,
  ]
  property_mappings_group = [
    data.authentik_property_mapping_provider_scim.scim_group_mapping.id,
  ]
}

# Custom user mapping for SCIM
resource "authentik_property_mapping_provider_scim" "aws_scim_user_mapping" {
  name       = "AWS SCIM User Mapping"
  expression = <<EOF
# https://docs.aws.amazon.com/singlesignon/latest/developerguide/createuser.html
#The givenName, familyName, userName, and displayName fields are required.

if " " in request.user.name:
    givenName, _, familyName = request.user.name.partition(" ")
else:
    givenName, familyName = request.user.name, " "

locale = request.user.locale()
if locale == "":
    locale = None

emails = []
if request.user.email != "":
    emails = [{
        "value": request.user.email,
        "type": "other",
        "primary": True,
    }]

return {
    "externalId": request.user.uid,
    "userName": request.user.username,
    "name": {
        "givenName": givenName,
        "familyName": familyName,
    },
    "displayName": request.user.name,
    "locale": locale,
    "active": request.user.is_active,
    "emails": emails,
}
EOF
}
```

I'm also using some data sources:

```terraform
data "authentik_certificate_key_pair" "default" {
  name = "authentik Self-signed Certificate"
}

data "authentik_group" "aws_users" {
  name = "aws-users"
}

data "authentik_property_mapping_provider_saml" "username" {
  managed = "goauthentik.io/providers/saml/username"
}

data "authentik_property_mapping_provider_scim" "scim_group_mapping" {
  managed = "goauthentik.io/providers/scim/group"
}
```

The key components here are:

1. **SAML Provider**: Configures the authentication part
2. **Property Mappings**: Define how Authentik user attributes map to AWS SAML claims
3. **SCIM Source**: Handles automatic user provisioning to AWS IAM Identity Center

## Name ID Mapping Considerations

This is where I noticed something important: depending on how you configure your SCIM username mapping, you need a corresponding name_id_mapping in your SAML provider.

In my configuration, I'm using the default `username` property mapping for the `name_id_mapping` field in the SAML provider (`data.authentik_property_mapping_provider_saml.username.id`). Looking at my SCIM mapping, I'm using `request.user.username` as the `userName` field in the SCIM mapping:

```python
return {
    "externalId": request.user.uid,
    "userName": request.user.username,
    # ... other fields
}
```

This alignment is critical because:

1. If your SCIM provisioning uses usernames as the `userName` field, your SAML name_id_mapping should also use the username attribute
2. If your SCIM provisioning uses emails as the `userName` field, your SAML name_id_mapping should use the email attribute

This was the key insight from [Authentik Issue #4554](https://github.com/goauthentik/authentik/issues/4554) - mismatching these will result in AWS IAM Identity Center failing to match SAML-authenticated users to their SCIM-provisioned identities. The user's SAML NameID must match the userName field in SCIM.

## User and Group Provisioning

With the SCIM integration in place, Authentik will automatically:

1. Create users in AWS IAM Identity Center when they're added to the specified group in Authentik
2. Update user attributes when they change in Authentik
3. Disable users in AWS IAM Identity Center when they're removed from the group in Authentik
4. Provision groups from Authentik to AWS IAM Identity Center

In my configuration, I've set up the following:

- Users are provisioned if they're in the "aws-users" group (`filter_group = data.authentik_group.aws_users.id`)
- Service accounts are excluded from provisioning (`exclude_users_service_account = true`)
- The standard Authentik SCIM group mapping is used for group provisioning (`data.authentik_property_mapping_provider_scim.scim_group_mapping.id`)
- The backchannel connection between the application and SCIM provider is established with `backchannel_providers`

The SCIM user mapping follows AWS IAM Identity Center's requirements for mandatory fields: givenName, familyName, userName, and displayName. The mapping handles users with or without spaces in their full name and properly formats the user data according to AWS specifications.

## AWS Permission Sets and Assignment

After users and groups are provisioned, we need to assign them to AWS accounts with appropriate permission sets. This can also be managed through Terraform. Here's how I've implemented it:

First, I create the permission set:

```terraform
data "aws_ssoadmin_instances" "identity_center" {}

locals {
  identity_center_arn = tolist(data.aws_ssoadmin_instances.identity_center.arns)[0]
  identity_store_id   = tolist(data.aws_ssoadmin_instances.identity_center.identity_store_ids)[0]
}

# This group is provisioned from Authentik via SCIM
data "aws_identitystore_group" "aws_administrators" {
  identity_store_id = local.identity_store_id
  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = "aws-administrators"
    }
  }
}

resource "aws_ssoadmin_permission_set" "administrator_access" {
  name             = "Administrator"
  description      = "Administrator access for all accounts"
  instance_arn     = local.identity_center_arn
  session_duration = "PT8H" # 8-hour sessions
}

resource "aws_ssoadmin_managed_policy_attachment" "administrator_access" {
  instance_arn       = local.identity_center_arn
  permission_set_arn = aws_ssoadmin_permission_set.administrator_access.arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
```

Then, I assign the permission set to specific AWS accounts using a module:

```terraform
resource "aws_ssoadmin_account_assignment" "aws_administrators" {
  instance_arn       = var.identity_center_arn
  permission_set_arn = var.administrator_access_arn

  principal_id   = var.aws_administrators_group_id
  principal_type = "GROUP"

  target_id   = aws_organizations_account.account.id
  target_type = "AWS_ACCOUNT"
}
```

This approach allows me to:

1. Define common permission sets (like AdministratorAccess) in a central place
2. Reference groups provisioned from Authentik via SCIM using their DisplayName
3. Assign these permission sets to specific AWS accounts
4. Manage everything through Terraform using Infrastructure as Code principles

By combining Authentik's SCIM provisioning with Terraform-managed AWS permission sets and assignments, I can control the entire access management lifecycle through code. When a user is added to or removed from the "aws-administrators" group in Authentik, the changes propagate through SCIM to AWS IAM Identity Center, and the appropriate permissions are automatically applied.

## Synchronization Flow

When everything is properly configured, the complete workflow looks like this:

1. User is created or added to the "aws-users" group in Authentik
2. User is automatically provisioned to AWS IAM Identity Center via SCIM
3. Terraform-managed permission sets are assigned to the groups the user belongs to (e.g., "aws-administrators")
4. User authenticates to AWS using Authentik via SAML
5. The user gains access to permitted AWS accounts and resources based on their group memberships
6. When access needs to be revoked, the user is simply removed from the appropriate group in Authentik

This creates a seamless access management pipeline that's both secure and maintainable. All changes are auditable through version control (for Terraform configurations) and through Authentik's logs (for user membership changes).

## Troubleshooting Common Issues

During implementation, I encountered several issues:

1. **Mismatched SAML and SCIM identifiers**: As mentioned, the SAML name_id_mapping must match how users are identified in SCIM
   
2. **Group provisioning issues**: Ensure group path templates in SCIM configuration match the actual group structure in Authentik

3. **Permission issues**: The SCIM token must have sufficient permissions to create/update users and groups

4. **Certificate validation**: For production use, ensure your SAML certificates are valid and not expired

5. **Attribute mapping**: AWS expects specific attributes for user profiles; ensure these are properly mapped in your SAML provider

Checking AWS CloudTrail logs and Authentik logs can help identify the specific issues.

## Conclusion

Integrating AWS IAM Identity Center with Authentik via SAML and SCIM provides a robust solution for centralized identity management across AWS environments. The key takeaway is ensuring consistent user identification between SAML authentication and SCIM provisioning.

The most critical insight from this implementation was the need to align the SAML name_id_mapping with the SCIM userName field. This seemingly small detail is essential for AWS IAM Identity Center to correctly match authenticated users with their provisioned identities.

By following the approach outlined in this post, you can:
- Automate user provisioning to AWS IAM Identity Center
- Provide a seamless single sign-on experience
- Centralize access management in Authentik
- Implement least-privilege access principles across your AWS organization

This integration completes our series on Authentik integrations, demonstrating how a single identity provider can secure and simplify access to various services in our infrastructure.

## Resources

- [AWS IAM Identity Center Documentation](https://docs.aws.amazon.com/singlesignon/)
- [Authentik SCIM Integration Documentation](https://goauthentik.io/docs/providers/scim)
- [Authentik AWS Integration Guide](https://docs.goauthentik.io/integrations/services/aws/#method-2-iam-identity-center)
- [AWS IAM Identity Center SCIM Implementation Guide](https://docs.aws.amazon.com/singlesignon/latest/userguide/scim-profile.html)
- [SAML Name ID to SCIM Username Issue](https://github.com/goauthentik/authentik/issues/4554)
- [SAML-tracer, a Firefox extension that aims to make debugging of SAML- and WS-Federation-communication between websites easier](https://github.com/SimpleSAMLphp/SAML-tracer)