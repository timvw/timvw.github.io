---
date: "2014-09-27T00:00:00Z"
guid: http://www.timvw.be/?p=2440
tags:
- bug
- libgdiplus
- mono
- osx
title: Failure to load mono-supplied .dylib (libgdiplus.dylib) when running from console
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