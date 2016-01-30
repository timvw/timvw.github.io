---
ID: 51
post_title: Windows Multimedia Video Capture
author: timvw
post_date: 2006-06-26 21:10:26
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/06/26/windows-multimedia-video-capture/
published: true
dsq_thread_id:
  - "1920134432"
---
<p>On my computer the <a href="http://msdn.microsoft.com/library/default.asp?url=/library/en-us/wia/wia/overviews/startpage.asp">WIA (Windows Image Acquisition)</a> API is SLOOOOOW. So i decided to give the <a href="http://windowssdk.msdn.microsoft.com/en-us/library/ms713477(VS.80).aspx">Windows Multimedia Video Capture</a> API a try. I didn't take long to <a href="http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpguide/html/cpconcreatingprototypesinmanagedcode.asp">create the prototypes in Managed Code</a> and <a href="http://msdn.microsoft.com/library/en-us/cpguide/html/cpconcallingdllfunction.asp">call the DLL functions</a>. Everything runs really smooth now... As always, feel free to download the <a href="http://www.timvw.be/wp-content/code/csharp/testavicap32.zip">testavicap32</a> sources now!</p>