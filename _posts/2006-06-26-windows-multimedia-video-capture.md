---
id: 51
title: Windows Multimedia Video Capture
date: 2006-06-26T21:10:26+00:00
author: timvw
layout: post
guid: http://www.timvw.be/windows-multimedia-video-capture/
permalink: /2006/06/26/windows-multimedia-video-capture/
dsq_thread_id:
  - 1920134432
tags:
  - 'C#'
  - Windows Forms
---
On my computer the [WIA (Windows Image Acquisition)](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/wia/wia/overviews/startpage.asp) API is SLOOOOOW. So i decided to give the [Windows Multimedia Video Capture](http://windowssdk.msdn.microsoft.com/en-us/library/ms713477(VS.80).aspx) API a try. I didn't take long to [create the prototypes in Managed Code](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cpguide/html/cpconcreatingprototypesinmanagedcode.asp) and [call the DLL functions](http://msdn.microsoft.com/library/en-us/cpguide/html/cpconcallingdllfunction.asp). Everything runs really smooth now... As always, feel free to download the [testavicap32](http://www.timvw.be/wp-content/code/csharp/testavicap32.zip) sources now!
