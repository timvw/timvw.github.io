---
id: 82
title: A Unix daemon
date: 2004-06-25T00:51:41+00:00
author: timvw
layout: post
guid: http://www.timvw.be/a-unix-daemon/
permalink: /2004/06/25/a-unix-daemon/
tags:
  - C++
---
Today i've written a daemon that communicates with the [Netsize SMS Gateway](http://www.netsize.com). The [daemon sources](http://www.timvw.be/wp-content/code/cpp/daemon.zip) are available for download. You will have to implement your void getCode(double number, char * code) method yourself though.

![daemon](http://www.timvw.be/wp-content/images/daemon.png)
