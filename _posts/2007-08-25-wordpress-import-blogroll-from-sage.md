---
id: 195
title: 'WordPress: Import Blogroll from Sage'
date: 2007-08-25T22:54:15+00:00
author: timvw
layout: post
guid: http://www.timvw.be/wordpress-import-blogroll-from-sage/
permalink: /2007/08/25/wordpress-import-blogroll-from-sage/
tags:
  - WordPress
---
Earlier today i exported the list with blogs i read from [Sage](http://sage.mozdev.org/) and tried to import them into [WordPress](http://wordpress.org). Although all the entries had been processed but none of them appeared. Apparently you have to rename the xmlUrl attribute to htmlUrl in the [OPML](http://en.wikipedia.org/wiki/OPML) file. With Vim that's as simple as ":%s/xmlUrl/htmlUrl/g".

Anyway, feel free to see if you find anything interesting in the [list of blogs i'm reading](http://www.timvw.be/wp-links-opml.php).
