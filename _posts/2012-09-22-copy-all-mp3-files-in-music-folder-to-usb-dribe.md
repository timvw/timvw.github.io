---
id: 2294
title: Copy all mp3 files in Music folder to USB dribe
date: 2012-09-22T22:08:46+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2294
permalink: /2012/09/22/copy-all-mp3-files-in-music-folder-to-usb-dribe/
categories:
  - Uncategorized
tags:
  - Bash
  - mac
---
Copying all mp3 files from my Music folder to a USB drive is pretty easy on my Macbook:

```bash
find Music -name *.mp3 -exec cp {} /Volumes/SANDISK \;
```