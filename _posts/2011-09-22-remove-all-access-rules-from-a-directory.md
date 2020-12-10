---
title: Remove all access rules from a directory
layout: post
guid: http://www.timvw.be/?p=2226
categories:
  - Uncategorized
tags:
  - C
  - security
---
A while ago i needed to write some code that removes all (existing/inherited) access rules from a given directory. It was pretty frustrating to notice that all my attempts seemed to fail ([RemoveAccessRule](http://msdn.microsoft.com/en-us/library/system.security.accesscontrol.commonobjectsecurity.removeaccessrule.aspx), [PurgeAccessRule](http://msdn.microsoft.com/en-us/library/system.security.accesscontrol.objectsecurity.purgeaccessrules.aspx), ...)

Finally i found that [SetAccessRuleProtection]() was the method that i needed to invoke.

```csharp
const string Folder = @"c:\temp\secured";
var directory = new DirectoryInfo(Folder);
var directorySecurity = directory.GetAccessControl();
directorySecurity.SetAccessRuleProtection(true,false);
directory.SetAccessControl(directorySecurity);
```
<br/>
<div id="attachment_2235" style="width: 387px" class="wp-caption alignnone">
  <a href="http://www.timvw.be/wp-content/uploads/2011/09/directorysecurity.png"><img src="http://www.timvw.be/wp-content/uploads/2011/09/directorysecurity.png" alt="Image of the security properties tab in windows" title="directorysecurity" width="377" height="461" class="size-full wp-image-2235" srcset="http://www.timvw.be/wp-content/uploads/2011/09/directorysecurity.png 377w, http://www.timvw.be/wp-content/uploads/2011/09/directorysecurity-245x300.png 245w" sizes="(max-width: 377px) 100vw, 377px" /></a>
  
  <p class="wp-caption-text">
    Image of the security properties tab in windows
  </p>
</div>

There you go 😉
