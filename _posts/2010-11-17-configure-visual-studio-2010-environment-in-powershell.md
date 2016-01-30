---
ID: 1982
post_title: >
  Configure Visual Studio 2010 environment
  in PowerShell
author: timvw
post_date: 2010-11-17 21:20:13
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/11/17/configure-visual-studio-2010-environment-in-powershell/
published: true
dsq_thread_id:
  - "1923727514"
---
<p>Instead of using the "Visual Studo Command Prompt (2010)" i wanted to use PowerShell instead. I found <a href="http://blogs.msdn.com/b/ploeh/archive/2008/04/09/visualstudio2008powershell.aspx">this</a> post which does it for VS2008. Extending it for VS2010 was pretty easy:</p>

[code lang="powershell"]
function SetVS2008()
{
    $vs90comntools = (Get-ChildItem env:VS90COMNTOOLS).Value
    $batchFile = [System.IO.Path]::Combine($vs90comntools, &quot;vsvars32.bat&quot;)
    Get-Batchfile $BatchFile
    [System.Console]::Title = &quot;Visual Studio 2008 Windows PowerShell&quot;
}

function SetVS2010()
{
    $vs100comntools = (Get-ChildItem env:VS100COMNTOOLS).Value
    $batchFile = [System.IO.Path]::Combine($vs100comntools, &quot;vsvars32.bat&quot;)
    Get-Batchfile $BatchFile
    [System.Console]::Title = &quot;Visual Studio 2010 Windows PowerShell&quot;
}

function Get-Batchfile($file) 
{
    $cmd = &quot;`&quot;$file`&quot; &amp; set&quot;
    cmd /c $cmd | Foreach-Object {
        $p, $v = $_.split('=')
        Set-Item -path env:$p -value $v
    }
}
[/code]