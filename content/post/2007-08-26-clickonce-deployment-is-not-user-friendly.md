---
date: "2007-08-26T00:00:00Z"
tags:
- C#
title: ClickOnce Deployment is not user-friendly!
aliases:
 - /2007/08/26/clickonce-deployment-is-not-user-friendly/
 - /2007/08/26/clickonce-deployment-is-not-user-friendly.html
---
Today i was experimenting with [ClickOnce Deployment](http://msdn2.microsoft.com/en-us/library/t71a733d(VS.80).aspx). Some people have warned for the elevation of permissions: [Be aware of ClickOnce default settings](http://www.leastprivilege.com/BewareBeAwareOfClickOnceDefaultSettings.aspx). What i find even more annoying is the fact that all you get to see are the following dialogs

![](http://www.timvw.be/wp-content/images/clickonce-permissions-01.gif)
  
![](http://www.timvw.be/wp-content/images/clickonce-permissions-02.gif)

If the user has to make an informed decision about the permissions he's going to grant to an application he should have atleast an easily accessible dialog that displays the PermissionSet that is being request. **Having to browse to the manifest file to find the PermissionSet is NOT user-friendly!**
