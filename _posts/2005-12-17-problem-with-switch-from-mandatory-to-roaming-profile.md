---
id: 62
title: Problem with switch from mandatory to roaming profile
date: 2005-12-17T21:38:25+00:00
author: timvw
layout: post
guid: http://www.timvw.be/problem-with-switch-from-mandatory-to-roaming-profile/
permalink: /2005/12/17/problem-with-switch-from-mandatory-to-roaming-profile/
tags:
  - Information Technology
---
Today i was experimenting with my [Windows Server 2003](http://en.wikipedia.org/wiki/Windows_Server_2003) and the [Active Directory](http://en.wikipedia.org/wiki/Active_Directory). I was able to setup [Roaming and Mandatory profiles](http://www.enterprisenetworkingplanet.com/netos/article.php/625291). After my tests with the mandatory profile i changed it back to a regular roaming profile. I was surprised when i noticed that my changes to the profile were not saved. It seems that files are copied from the active directory to the domain pc (but not removed). The problem is that if there is already a ntuser.man file on the domain pc this pc will continue to think that it's a mandatory profile. Solution: Remove the copy of the profile on the domain pc.
