---
ID: 2103
post_title: Global hotkeys for iTunes on windows
author: timvw
post_date: 2011-03-16 19:57:07
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2011/03/16/global-hotkeys-for-itunes-on-windows/
published: true
dsq_thread_id:
  - "1933325240"
---
<p>These days i use iTunes as media player. Unlike winamp this program does not seem to support system-wide hotkeys to control playback. This is the place where a productivity tool like <a href="http://www.autohotkey.com/">AutoHotkey</a> comes into the rescue ;).</p>

<p>I have configured the following keys:</p>
<ul>
<li>Move to next song: [Ctrl] + [Alt] + [Right]</li>
<li>Move to previous song: [Ctrl] + [Alt] + [Left]</li>
<li>Toggle play/pause: [Ctrl] + [Alt] + p</li>
<li>Turn volume up: [Ctrl] + [Alt] + [Up]</li>
<li>Turn volume down: [Ctrl] + [Alt] + [Down]</li>
</ul>

[code lang="plain"]
^!right::
DetectHiddenWindows , On
ControlSend , ahk_parent, ^{right}, iTunes ahk_class iTunes
DetectHiddenWindows , Off
return

^!left::
DetectHiddenWindows , On
ControlSend , ahk_parent, ^{left}, iTunes ahk_class iTunes
DetectHiddenWindows , Off
return

^!p::
DetectHiddenWindows , On
ControlSend , ahk_parent, {space}, iTunes ahk_class iTunes
DetectHiddenWindows , Off
return

^!up::
DetectHiddenWindows , On
ControlSend, ahk_parent, ^{UP}, iTunes ahk_class iTunes
DetectHiddenWindows , Off
return

^!down::
DetectHiddenWindows , On
ControlSend, ahk_parent, ^{DOWN}, iTunes ahk_class iTunes
DetectHiddenWindows , Off
return
[/code]