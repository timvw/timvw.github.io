---
title: Force the removal of a file with PowerShell
layout: post
guid: http://www.timvw.be/?p=2240
dsq_thread_id:
  - 1924296740
categories:
  - Uncategorized
tags:
  - PowerShell
---
Last couple of weeks I have been generating a lot of files (and restricting their ACLs) and today I decided to remove all those files. The problem is that my user account did not have permissions on those files. Here is a small script that will first take ownership of the file, then grants FullControl permissions, and finally removes the file 🙂

```powershell
function RemoveFile 
{	  
	param($FileName)
	
	&takeown /F $FileName
	$User = [System.Security.Principal.WindowsIdentity]::GetCurrent().User
	$Acl = Get-Acl $FileName	  
	$Acl.SetOwner($User)	  
	$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($User, "FullControl", "Allow")	  
	$Acl.SetAccessRule($AccessRule)	  
	Set-Acl $FileName $Acl
	Remove-Item $FileName 
}

Get-ChildItem *.txt -R | % { RemoveFile $_.FullName; }
```
**Edit on 2011-10-19**

Resetting the permissions with icacls c:\output /reset /t and then calling Remove-Item c:\output -R does the trick.

```powershell
function RemoveFiles 
{  
	param($Directory)

	icacls $Directory /reset /t 
	Remove-Item $Directory -R 
}

RemoveFiles c:\output;
```
