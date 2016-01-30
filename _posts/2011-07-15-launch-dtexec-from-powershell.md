---
ID: 2163
post_title: Launch DtExec from PowerShell
author: timvw
post_date: 2011-07-15 18:47:01
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/07/15/launch-dtexec-from-powershell/
published: true
dsq_thread_id:
  - "1920433465"
---
<p>Running an SSIS package from PowerShell (using DTExec) can be as simple as:</p>

[code lang="powershell"]
RunPackage -File 'C:\test.dtsx' -DatabaseHost '.' -DatabaseName 'TEST';
[/code]

<p>Here are the functions that make it this simple:</p>

[code lang="powershell"]
function GetDtExecPath {
    $DtsPath = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server\100\DTS\Setup').SQLPath;
    $DtExecPath = (Resolve-Path &quot;$DtsPath\Binn\DTExec.exe&quot;);
    $DtExecPath;
}

function GetDtExecPropertyPathValue() {
    param(
        $PropertyPath = '',
        $Value = ''
    );
    &quot;$PropertyPath;\`&quot;`&quot;$Value\`&quot;`&quot;&quot;;
}

function RunPackage {
    param(
        $DtExecPath = (GetDtExecPath),
        $File = 'test.dtsx'
    );
    
    $Params = &quot;/FILE $File&quot;;
    for($i = 0; $i -lt $Args.Length; $i += 2) {
        $PropertyPath = $Args[$i].SubString(1);
        $Value = $Args[$i+1];
        $PropertyPathValue = GetDtExecPropertyPathValue -PropertyPath $PropertyPath -Value $Value;
        $Params += &quot; /SET $PropertyPathValue&quot;;
    } 
    
    &amp;&quot;$DtExecPath&quot; $Params;
}
[/code]