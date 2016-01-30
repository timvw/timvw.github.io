---
ID: 2440
post_title: >
  Failure to load mono-supplied .dylib
  (libgdiplus.dylib) when running from
  console
author: timvw
post_date: 2014-09-27 09:16:37
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2014/09/27/failure-to-load-mono-supplied-dylib-libgdiplus-dylib-when-running-from-console/
published: true
---
<p>So earlier this week I was bit by the following bug: <a href="https://bugzilla.xamarin.com/show_bug.cgi?id=22140">Bug 22140 - Failure to load mono-supplied .dylib when running from console.</a></p>

<p>The workaround that works for me is the following: Edit /Library/Frameworks/Mono.framework/Versions/3.8.0/etc/mono/config and
replace the entries for libgdiplus:</p>

[code language="xml"]
&lt;dllmap dll=&quot;gdiplus&quot;
target=&quot;/Library/Frameworks/Mono.framework/Versions/3.8.0/lib/libgdiplus.dylib&quot;
os=&quot;!windows&quot;/&gt;
    &lt;dllmap dll=&quot;gdiplus.dll&quot;
target=&quot;/Library/Frameworks/Mono.framework/Versions/3.8.0/lib/libgdiplus.dylib&quot;
 os=&quot;!windows&quot;/&gt;
    &lt;dllmap dll=&quot;gdi32&quot;
target=&quot;/Library/Frameworks/Mono.framework/Versions/3.8.0/lib/libgdiplus.dylib&quot;
os=&quot;!windows&quot;/&gt;
    &lt;dllmap dll=&quot;gdi32.dll&quot;
target=&quot;/Library/Frameworks/Mono.framework/Versions/3.8.0/lib/libgdiplus.dylib&quot;
os=&quot;!windows&quot;/&gt;
[/code]