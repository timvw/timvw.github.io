---
id: 50
title: Windows Image Acquisition
date: 2006-06-24T21:09:27+00:00
author: timvw
layout: post
guid: http://www.timvw.be/windows-image-acquisition/
permalink: /2006/06/24/windows-image-acquisition/
dsq_thread_id:
  - 1920134403
tags:
  - 'C#'
  - Windows Forms
---
Earlier today i decided to toy around with my webcam. A couple of websearches later i ended up at [WIA (Windows Image Acquisition)](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/wia/wia/overviews/startpage.asp). I found a couple of articles (eg: [here](http://msdn.microsoft.com/coding4fun/someassemblyrequired/lookatme/default.aspx) and [here](http://blogs.msdn.com/robburke/archive/2005/09/21/472541.aspx)) that showed how to capture images. I wanted to display the caputered image in a [PictureBox](http://msdn2.microsoft.com/en-us/library/system.windows.forms.picturebox.aspx). Unfortunately everybody seems to save the WIA.ImageFile to a file and then load the imagefile into a PictureBox. It's obvious that i don't want to save the image into a file first. Here is my workaround

```csharp
// Load the ImageFile into a PictureBox
pbImage.Image = Image.FromStream(new MemorySteam((byte[]) imgf.FileData.get_BinaryData()));
```
