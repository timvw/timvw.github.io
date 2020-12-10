---
title: Deploying a Cloud Service to Azure with Octopus
layout: post
guid: http://www.timvw.be/?p=2430
categories:
  - Uncategorized
tags:
  - Dev-Ops
  - Octopus
  - PowerShell
---
Currently Octopus has limited support to deploy a Cloud Service on Azure. A typical use-case is that you need a different Web.Config file per environment. Simply add the Web.Environment.Config files to your NuGet package and use the following [PreDeploy.ps1](https://gist.github.com/timvw/4e32226dd1ff149b5eab.js) script:

```powershell  
# Load unzip support
[Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem") | Out-Null
function Unzip($zipFile, $destination)
{
	If (Test-Path $destination){	  
		Remove-Item $destination -Recurse | Out-Null
	}
	  
	New-Item -ItemType directory -Force -Path $destination | Out-Null  
	[System.IO.Compression.ZipFile]::ExtractToDirectory($zipFile, $destination) | Out-Null
}

# Unzip deployment package  
$CsPkg = "Customer.Project.Api.Azure.cspkg"
Unzip $CsPkg "azurePackage"
Unzip (Get-Item (join-path -path "azurePackage" -childPath "*.cssx")) "website"

# Perform replacements, eg: replace Web.Config  
$ConfigFileToUse = "Web." + $OctopusParameters["Octopus.Environment.Name"] + ".config"
Copy-Item -Path $ConfigFileToUse -Destination "website/sitesroot/0/Web.Config" -Force

# Repackage  
$role = "Customer.Project.Api"
$contentPath = "website\approot"
$rolePath = "website/approot"
$webPath = "website/sitesroot/0"
$cspackPath = "C:\Program Files\Microsoft SDKs\Windows Azure\.NET SDK\v2.2\bin\cspack.exe"
& $cspackPath "ServiceDefinition.csdef" "/out:$CsPkg" "/role:$role;$rolePath;Customer.Project.Api.dll" "/sites:$role;Web;$webPath" "/sitePhysicalDirectories:$role;Web;$webPath"  
```