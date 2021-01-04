---
date: "2011-07-15T00:00:00Z"
guid: http://www.timvw.be/?p=2163
tags:
- PowerShell
- SSIS
title: Launch DtExec from PowerShell
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
