---
ID: 2430
post_title: >
  Deploying a Cloud Service to Azure with
  Octopus
author: timvw
post_date: 2014-08-15 06:41:03
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2014/08/15/deploying-a-cloud-service-to-azure-with-octopus/
published: true
---
Currently Octopus has limited support to deploy a Cloud Service on Azure. A typical use-case is that you need a different Web.Config file per environment. Simply add the Web.Environment.Config files to your NuGet package and use the following <a href="https://gist.github.com/timvw/4e32226dd1ff149b5eab.js">PreDeploy.ps1</a> script:

[code language="powershell"]
# Load unzip support
[Reflection.Assembly]::LoadWithPartialName(&quot;System.IO.Compression.FileSystem&quot;) | Out-Null

function Unzip($zipFile, $destination)
{
	If (Test-Path $destination){
		Remove-Item $destination -Recurse | Out-Null
	}
	New-Item -ItemType directory -Force -Path $destination | Out-Null
	[System.IO.Compression.ZipFile]::ExtractToDirectory($zipFile, $destination) | Out-Null
}

# Unzip deployment package
$CsPkg = &quot;Customer.Project.Api.Azure.cspkg&quot;
Unzip $CsPkg &quot;azurePackage&quot;
Unzip (Get-Item (join-path -path &quot;azurePackage&quot; -childPath &quot;*.cssx&quot;)) &quot;website&quot;

# Perform replacements, eg: replace Web.Config
$ConfigFileToUse = &quot;Web.&quot; + $OctopusParameters[&quot;Octopus.Environment.Name&quot;] + &quot;.config&quot;
Copy-Item -Path $ConfigFileToUse -Destination &quot;website/sitesroot/0/Web.Config&quot; -Force

# Repackage
$role = &quot;Customer.Project.Api&quot;
$contentPath = &quot;website\approot&quot;
$rolePath = &quot;website/approot&quot;
$webPath = &quot;website/sitesroot/0&quot;
$cspackPath = &quot;C:\Program Files\Microsoft SDKs\Windows Azure\.NET SDK\v2.2\bin\cspack.exe&quot;
&amp; $cspackPath &quot;ServiceDefinition.csdef&quot; &quot;/out:$CsPkg&quot; &quot;/role:$role;$rolePath;Customer.Project.Api.dll&quot; &quot;/sites:$role;Web;$webPath&quot; &quot;/sitePhysicalDirectories:$role;Web;$webPath&quot; 
[/code]