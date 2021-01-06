---
date: 2021-01-06
title: bye-travis-hello-github-actions
draft: true
tags:
- travis-ci
- github-actions
- ci
---
A while ago I was notified that [travis-ci.org](https://travis-ci.org/) was shutting down.
Migrating to [Github Actions](https://github.com/features/actions) was like a walk in the park.

On each push the code is compiled and tested. Whenever a tag (v1.0.9) is pushed, that tag is released.

Here is the workflow for [frameless-ext](https://github.com/timvw/frameless-ext):

```yaml
name: workflow

on: push

jobs:
  build:

    runs-on: ubuntu-latest

    steps:

    - uses: actions/checkout@v2

    - name: Set up JDK 1.8
      uses: actions/setup-java@v1
      with:
        java-version: 1.8

    - name: Test
      run: sbt '+clean; +cleanFiles; +compile; +test'
      
    - name: Release
      if: startsWith(github.ref, 'refs/tags/v')
      run: sbt 'ci-release'
      env:
        PGP_PASSPHRASE: ${{ secrets.PGP_PASSPHRASE }}
        PGP_SECRET: ${{ secrets.PGP_SECRET }}
        SONATYPE_PASSWORD: ${{ secrets.SONATYPE_PASSWORD }}
        SONATYPE_USERNAME: ${{ secrets.SONATYPE_USERNAME }}
```

