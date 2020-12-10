---
title: Configure Visual Studio 2010 environment in PowerShell
layout: post
guid: http://www.timvw.be/?p=1982
categories:
  - Uncategorized
tags:
  - PowerShell
  - Visual Studio
---
Instead of using the "Visual Studo Command Prompt (2010)" i wanted to use PowerShell instead. I found [this](http://blogs.msdn.com/b/ploeh/archive/2008/04/09/visualstudio2008powershell.aspx) post which does it for VS2008. Extending it for VS2010 was pretty easy:

```powershell
function SetVS2008()
{
	$vs90comntools = (Get-ChildItem env:VS90COMNTOOLS).Value
	$batchFile = [System.IO.Path]::Combine($vs90comntools, "vsvars32.bat")
	Get-Batchfile $BatchFile
	[System.Console]::Title = "Visual Studio 2008 Windows PowerShell"
}

function SetVS2010()
{
	$vs100comntools = (Get-ChildItem env:VS100COMNTOOLS).Value
	$batchFile = [System.IO.Path]::Combine($vs100comntools, "vsvars32.bat")
	Get-Batchfile $BatchFile
	[System.Console]::Title = "Visual Studio 2010 Windows PowerShell"
}

function Get-Batchfile($file)
{
	$cmd = "\`"$file\`" & set"
	cmd /c $cmd | Foreach-Object {
		$p, $v = $_.split('=')
		Set-Item -path env:$p -value $v
	}
}
```
