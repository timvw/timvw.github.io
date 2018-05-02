---
id: 2163
title: Launch DtExec from PowerShell
date: 2011-07-15T18:47:01+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2163
permalink: /2011/07/15/launch-dtexec-from-powershell/
dsq_thread_id:
  - 1920433465
categories:
  - Uncategorized
tags:
  - PowerShell
  - SSIS
---
Running an SSIS package from PowerShell (using DTExec) can be as simple as:

```powershell 
RunPackage -File 'C:\test.dtsx' -DatabaseHost '.' -DatabaseName 'TEST';
```

Here are the functions that make it this simple:

```powershell
function GetDtExecPath {    
  $DtsPath = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\100\DTS\Setup').SQLPath;    
  $DtExecPath = (Resolve-Path "$DtsPath\Binn\DTExec.exe");    
  $DtExecPath;
}

function GetDtExecPropertyPathValue() {      
  param(
    $PropertyPath = '',
    $Value = '';
  );

  "$PropertyPath;\`"\`"$Value\`"\`"";
}

function RunPackage {
      
  param(        
  $DtExecPath = (GetDtExecPath),       
  $File = 'test.dtsx'  
  );

  $Params = "/FILE $File";
   
  for($i = 0; $i -lt $Args.Length; $i += 2) {       
    $PropertyPath = $Args[$i].SubString(1);       
    $Value = $Args[$i+1];       
    $PropertyPathValue = GetDtExecPropertyPathValue -PropertyPath $PropertyPath -Value $Value;       
    $Params += " /SET $PropertyPathValue";    
  } 

  &"$DtExecPath" $Params;
}
```
