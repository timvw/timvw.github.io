---
ID: 2226
post_title: Remove all access rules from a directory
author: timvw
post_date: 2011-09-22 18:56:04
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/09/22/remove-all-access-rules-from-a-directory/
published: true
dsq_thread_id:
  - "1923585402"
---
<p>A while ago i needed to write some code that removes all (existing/inherited) access rules from a given directory. It was pretty frustrating to notice that all my attempts seemed to fail (<a href="http://msdn.microsoft.com/en-us/library/system.security.accesscontrol.commonobjectsecurity.removeaccessrule.aspx">RemoveAccessRule</a>, <a href="http://msdn.microsoft.com/en-us/library/system.security.accesscontrol.objectsecurity.purgeaccessrules.aspx">PurgeAccessRule</a>, ...)</p>

<p>Finally i found that <a href="">SetAccessRuleProtection</a> was the method that i needed to invoke.</p>

[code lang="csharp"]
const string Folder = @&quot;c:\temp\secured&quot;;
var directory = new DirectoryInfo(Folder);
var directorySecurity = directory.GetAccessControl();
directorySecurity.SetAccessRuleProtection(true,false);
directory.SetAccessControl(directorySecurity);
[/code]

[caption id="attachment_2235" align="alignnone" width="377" caption="Image of the security properties tab in windows"]<a href="http://www.timvw.be/wp-content/uploads/2011/09/directorysecurity.png"><img src="http://www.timvw.be/wp-content/uploads/2011/09/directorysecurity.png" alt="Image of the security properties tab in windows" title="directorysecurity" width="377" height="461" class="size-full wp-image-2235" /></a>[/caption]

<p>There you go ;)</p>