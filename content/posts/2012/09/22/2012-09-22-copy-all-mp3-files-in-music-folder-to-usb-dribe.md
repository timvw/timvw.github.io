---
date: "2012-09-22T00:00:00Z"
guid: http://www.timvw.be/?p=2294
tags:
- Bash
- mac
title: Copy all mp3 files in Music folder to USB dribe
aliases:
 - /2012/09/22/copy-all-mp3-files-in-music-folder-to-usb-dribe/
 - /2012/09/22/copy-all-mp3-files-in-music-folder-to-usb-dribe.html
---
Copying all mp3 files from my Music folder to a USB drive is pretty easy on my Macbook:

```bash
find Music -name *.mp3 -exec cp {} /Volumes/SANDISK \;
```