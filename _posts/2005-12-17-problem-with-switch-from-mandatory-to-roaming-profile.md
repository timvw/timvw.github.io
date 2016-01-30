---
ID: 62
post_title: >
  Problem with switch from mandatory to
  roaming profile
author: timvw
post_date: 2005-12-17 21:38:25
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/12/17/problem-with-switch-from-mandatory-to-roaming-profile/
published: true
---
<p>Today i was experimenting with my <a href="http://en.wikipedia.org/wiki/Windows_Server_2003">Windows Server 2003</a> and the <a href="http://en.wikipedia.org/wiki/Active_Directory">Active Directory</a>. I was able to setup <a href="http://www.enterprisenetworkingplanet.com/netos/article.php/625291">Roaming and Mandatory profiles</a>. After my tests with the mandatory profile i changed it back to a regular roaming profile. I was surprised when i noticed that my changes to the profile were not saved. It seems that files are copied from the active directory to the domain pc (but not removed). The problem is that if there is already a ntuser.man file on the domain pc this pc will continue to think that it's a mandatory profile. Solution: Remove the copy of the profile on the domain pc.</p>