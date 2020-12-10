---
title: Copy all mp3 files in Music folder to USB dribe
layout: post
guid: http://www.timvw.be/?p=2294
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