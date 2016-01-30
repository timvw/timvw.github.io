---
ID: 50
post_title: Windows Image Acquisition
author: timvw
post_date: 2006-06-24 21:09:27
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/06/24/windows-image-acquisition/
published: true
dsq_thread_id:
  - "1920134403"
---
<p>Earlier today i decided to toy around with my webcam. A couple of websearches later i ended up at <a href="http://msdn.microsoft.com/library/default.asp?url=/library/en-us/wia/wia/overviews/startpage.asp">WIA (Windows Image Acquisition)</a>. I found a couple of articles (eg: <a href="http://msdn.microsoft.com/coding4fun/someassemblyrequired/lookatme/default.aspx">here</a> and <a href="http://blogs.msdn.com/robburke/archive/2005/09/21/472541.aspx">here</a>) that showed how to capture images. I wanted to display the caputered image in a <a href="http://msdn2.microsoft.com/en-us/library/system.windows.forms.picturebox.aspx">PictureBox</a>. Unfortunately everybody seems to save the WIA.ImageFile to a file and then load the imagefile into a PictureBox. It's obvious that i don't want to save the image into a file first. Here is my workaround:</p>

[code lang="csharp"]
// Load the ImageFile into a PictureBox
pbImage.Image = Image.FromStream(new MemorySteam((byte[]) imgf.FileData.get_BinaryData()));
[/code]