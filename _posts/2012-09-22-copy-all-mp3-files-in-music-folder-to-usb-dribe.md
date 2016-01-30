---
ID: 2294
post_title: >
  Copy all mp3 files in Music folder to
  USB dribe
author: timvw
post_date: 2012-09-22 22:08:46
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2012/09/22/copy-all-mp3-files-in-music-folder-to-usb-dribe/
published: true
---
Copying all mp3 files from my Music folder to a USB drive is pretty easy on my Macbook:

[code lang="bash"]
find Music -name *.mp3 -exec cp {} /Volumes/SANDISK \;
[/code]