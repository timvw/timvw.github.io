---
date: 2021-01-07
title: Blog migrated to HUGO
tags:
- meta
- blog
- github-actions
- ci
---
Tired of jekyll (plugin) dependency hell I decided to swith to [HUGO](https://gohugo.io/). It's fast, really fast.

[Github Actions](https://github.com/features/actions) is used to generate  the website and the hosting is done by github.

The workflow is fairly simple:

```yaml
name: Publish on push to master

on:
  push:
    branches:
      - master

jobs:
  build_and_deploy_job:
    runs-on: ubuntu-latest
    name: Build and Deploy Job
    steps:
      - name: Checkout sources
        uses: actions/checkout@v2
        with:
          submodules: true

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: '0.80.0'
          extended: true

      - name: Build
        run: hugo
        
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
```

PS: Whenever [azure](https://azure.microsoft.com/en-us/) blob-storage (or static websites) gets proper support (no DNS flattening hacks) for hosting websites from a storage account I might consider moving the hosting over there...


