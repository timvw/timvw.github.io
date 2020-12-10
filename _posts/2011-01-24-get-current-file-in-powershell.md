---
title: Get current file in PowerShell
layout: post
guid: http://www.timvw.be/?p=2044
categories:
  - Uncategorized
tags:
  - PowerShell
---
A while ago i wrote a small script to take care of deployment. Configuring the source folders went as following:

```powershell
param(  
  $BaseDir = (Get-Location).Path,  
  $WebDir = (Resolve-Path "$BaseDir\web"),  
  $DatabaseDir = (Resolve-Path "$BaseDir\database")
)
```

The problem with this code is that it only works when your current working directory is set to the location of this script. An administrator (or build system) invokes the script as following:

```powershell
PS C:\Users\Admin>& 'D:\Deployments\20110124\Deploy.ps1';
```

Because we don't want to annoy the consumer of our script with the burden of making sure he is in the correct directory we modified our code as following:

```powershell
param(  
  $BaseDir = (Split-Path $MyInvocation.MyCommand.Definition),  
  $WebDir = (Resolve-Path "$BaseDir\web"),	  
  $DatabaseDir = (Resolve-Path "$BaseDir\database")  
)  
```

A quick win 🙂
