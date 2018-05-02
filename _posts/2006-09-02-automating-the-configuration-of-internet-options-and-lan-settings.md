---
id: 45
title: Automating the configuration of Internet Options / Lan Settings
date: 2006-09-02T19:51:09+00:00
author: timvw
layout: post
guid: http://www.timvw.be/45/
permalink: /2006/09/02/automating-the-configuration-of-internet-options-and-lan-settings/
tags:
  - Information Technology
---
I got tired of manually changing my Internet Options / Lan Settings. It was really time to say goodbye to the dialog below

![screenshot of lan settings dialog](http://www.timvw.be/wp-content/images/lansettingsdialog.jpg)

With the help of [How to add, modify, or delete registry subkeys and values by using a registration entries (.reg) file](http://support.microsoft.com/kb/310516/) i wrote two little files that add/remove the automatic configuration location.The work.reg file looks like

```reg
REGEDIT4
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings]
"AutoConfigURL"="http://192.168.1.99/"
```

And the home.reg file looks like:

```reg
REGEDIT4
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings]
"AutoConfigURL"=-
```
