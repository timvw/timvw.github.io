---
id: 102
title: Read from STDIN without echoing the input back
date: 2005-07-24T01:57:14+00:00
author: timvw
layout: post
guid: http://www.timvw.be/read-from-stdin-without-echoing-the-input-back/
permalink: /2005/07/24/read-from-stdin-without-echoing-the-input-back/
tags:
  - PHP
---
Today i was looking for a way to read passwords from a PHP-CLI script. So it was important the password didn't appear on the console. I wrote a [ttyecho function](http://www.timvw.be/wp-content/code/php/ttyecho.php.txt) that uses [stty](http://unixhelp.ed.ac.uk/CGI/man-cgi?stty) to change the terminal line settings.
