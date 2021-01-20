---
date: 2021-01-20
title: Use cases for Github Actions
draft: false
tags:
- meta
- blog
- github-actions
- ci
---
These days many systems are built with [Unix Philosophy](http://catb.org/~esr/writings/taoup/html/ch01s06.html) in mind,
but the applications are in the form of [containers](https://opencontainers.org/). How many malicious containers images would be out there? :)

Here are a couple of examples where I leveraged [Github Actions](https://github.com/features/actions) to glue such applications:
- [Publishing this blog with HUGO]({{< ref "#hugo" >}} "hugo")
- [Releasing on central]({{< ref "#central" >}} "central")
- [Managing cloud infrastructure]({{< ref "#terraform" >}} "terraform")


## Publishing this blog with HUGO {#hugo}

Frustrated with jekyll ndependency hell I decided to swith to [HUGO](https://gohugo.io/). It's fast, really fast. And does whatever I need it to do.

Each time I push commits to this repository, this repository is checked out, hugo generates the static website and that website is push to [gh-pages](https://github.com/timvw/timvw.github.io/tree/gh-pages) for delivery.

https://github.com/timvw/timvw.github.io/blob/master/.github/workflows/publish.yml

PS: Whenever [azure](https://azure.microsoft.com/en-us/) blob-storage (or static websites) gets proper support (no DNS flattening hacks) for hosting websites from a storage account I might consider moving the hosting over there...

## Releasing on central {#java}

With the shutdown of [travis-ci.org](https://travis-ci.org/) in sight it was time to migrate to an alternative system to release artifacts on [central](https://central.sonatype.org/). 

Each time a commit is pushed to this repository, a build (and test) is triggered. Whenever a tag is pushed, that tag is released.

https://github.com/timvw/frameless-ext/blob/master/.github/workflows/ci.yml

## Managing cloud infrastructure {#terraform}

When you have automated the provisioning of your cloud infrastructure with a tool such as [Terraform](https://www.terraform.io/) you may want to automate the roll-out as well. Careful, as this currently requires some annoying "in between" steps to avoid **big bang** deployments. You probably do not want to replace an entire pool of nodes by simply wiping it and putting another pool in place (but do it in a phased approach.

So, each time a PR is created (or updated) we run terraform plan to validate the output and add a comment to the PR displaying the output. When the PR is merged into master you we run terraform apply (and add a comment to the commit with the output).

https://gist.github.com/timvw/7a245947a9b3b027d5a0fcd5ad3d9977

PS: In this example we have multiple terraform modules, which are all planned/applied via a [matrix](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstrategymatrix) and terraform's -chdir parameter.