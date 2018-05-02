---
id: 2440
title: Failure to load mono-supplied .dylib (libgdiplus.dylib) when running from console
date: 2014-09-27T09:16:37+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2440
permalink: /2014/09/27/failure-to-load-mono-supplied-dylib-libgdiplus-dylib-when-running-from-console/
categories:
  - Uncategorized
tags:
  - bug
  - libgdiplus
  - mono
  - osx
---
So earlier this week I was bit by the following bug: [Bug 22140 -- Failure to load mono-supplied .dylib when running from console.](https://bugzilla.xamarin.com/show_bug.cgi?id=22140)

The workaround that works for me is the following: Edit /Library/Frameworks/Mono.framework/Versions/3.8.0/etc/mono/config and
  
replace the entries for libgdiplus:

```xml
<dllmap dll="gdiplus" target="/Library/Frameworks/Mono.framework/Versions/3.8.0/lib/libgdiplus.dylib" os="!windows"/>
<dllmap dll="gdiplus.dll" target="/Library/Frameworks/Mono.framework/Versions/3.8.0/lib/libgdiplus.dylib" os="!windows"/>
<dllmap dll="gdi32" target="/Library/Frameworks/Mono.framework/Versions/3.8.0/lib/libgdiplus.dylib" os="!windows"/>
<dllmap dll="gdi32.dll" target="/Library/Frameworks/Mono.framework/Versions/3.8.0/lib/libgdiplus.dylib" os="!windows"/>
```