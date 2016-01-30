---
ID: 198
post_title: >
  ClickOnce Deployment is not
  user-friendly!
author: timvw
post_date: 2007-08-26 15:59:22
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/08/26/clickonce-deployment-is-not-user-friendly/
published: true
---
<p>Today i was experimenting with <a href="http://msdn2.microsoft.com/en-us/library/t71a733d(VS.80).aspx">ClickOnce Deployment</a>. Some people have warned for the elevation of permissions: <a href="http://www.leastprivilege.com/BewareBeAwareOfClickOnceDefaultSettings.aspx">Be aware of ClickOnce default settings</a>. What i find even more annoying is the fact that all you get to see are the following dialogs:</p>
<img src="http://www.timvw.be/wp-content/images/clickonce-permissions-01.gif" alt=""/><br/>
<img src="http://www.timvw.be/wp-content/images/clickonce-permissions-02.gif" alt=""/><br/>
<p>If the user has to make an informed decision about the permissions he's going to grant to an application he should have atleast an easily accessible dialog that displays the PermissionSet that is being request. <b>Having to browse to the manifest file to find the PermissionSet is NOT user-friendly!</b></p>