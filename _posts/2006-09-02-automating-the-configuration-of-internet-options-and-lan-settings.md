---
ID: 45
post_title: >
  Automating the configuration of Internet
  Options / Lan Settings
author: timvw
post_date: 2006-09-02 19:51:09
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/09/02/automating-the-configuration-of-internet-options-and-lan-settings/
published: true
---
<p>I got tired of manually changing my Internet Options / Lan Settings. It was really time to say goodbye to the dialog below:</p>
<img src="http://www.timvw.be/wp-content/images/lansettingsdialog.jpg" alt="screenshot of lan settings dialog"/>
<p>With the help of <a href="http://support.microsoft.com/kb/310516/">How to add, modify, or delete registry subkeys and values by using a registration entries (.reg) file</a> i wrote two little files that add/remove the automatic configuration location.The work.reg file looks like:</p>
[code lang="reg"]
REGEDIT4
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings]
"AutoConfigURL"="http://192.168.1.99/"
[/code]
<p>And the home.reg file looks like:</p>
[code lang="reg"]
REGEDIT4
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings]
"AutoConfigURL"=-
[/code]