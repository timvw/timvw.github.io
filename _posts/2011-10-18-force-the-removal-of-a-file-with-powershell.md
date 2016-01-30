---
ID: 2240
post_title: >
  Force the removal of a file with
  PowerShell
author: timvw
post_date: 2011-10-18 19:44:08
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/10/18/force-the-removal-of-a-file-with-powershell/
published: true
dsq_thread_id:
  - "1924296740"
---
<p>Last couple of weeks I have been generating a lot of files (and restricting their ACLs) and today I decided to remove all those files. The problem is that my user account did not have permissions on those files. Here is a small script that will first take ownership of the file, then grants FullControl permissions, and finally removes the file :)</p>

[code lang="powershell"]
function RemoveFile
{
	param($FileName)
	
	&amp;takeown /F $FileName
	
	$User = [System.Security.Principal.WindowsIdentity]::GetCurrent().User
	
	$Acl = Get-Acl $FileName
	$Acl.SetOwner($User)
	$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($User, &quot;FullControl&quot;, &quot;Allow&quot;)
	$Acl.SetAccessRule($AccessRule)
	Set-Acl $FileName $Acl

	Remove-Item $FileName
}

Get-ChildItem *.txt -R | % { RemoveFile $_.FullName; }
[/code]

<b>Edit on 2011-10-19</b>
<p>Resetting the permissions with icacls c:\output /reset /t and then calling Remove-Item c:\output -R does the trick.</p>

[code lang="powershell"]
function RemoveFiles
{
 param($Directory)
 icacls $Directory /reset /t
 Remove-Item $Directory -R
}

RemoveFiles c:\output;
[/code]