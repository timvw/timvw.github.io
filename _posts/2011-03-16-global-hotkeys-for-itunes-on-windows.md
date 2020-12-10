---
title: Global hotkeys for iTunes on windows
layout: post
guid: http://www.timvw.be/?p=2103
dsq_thread_id:
  - 1933325240
categories:
  - Uncategorized
tags:
  - AutoHotkey
  - iTunes
---
These days i use iTunes as media player. Unlike winamp this program does not seem to support system-wide hotkeys to control playback. This is the place where a productivity tool like [AutoHotkey](http://www.autohotkey.com/) comes into the rescue ;).

I have configured the following keys:

  * Move to next song: [Ctrl] + [Alt] + [Right]
  * Move to previous song: [Ctrl] + [Alt] + [Left]
  * Toggle play/pause: [Ctrl] + [Alt] + p
  * Turn volume up: [Ctrl] + [Alt] + [Up]
  * Turn volume down: [Ctrl] + [Alt] + [Down]


```bash
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
```
