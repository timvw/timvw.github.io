---
date: "2007-08-25T00:00:00Z"
tags:
- WordPress
title: 'WordPress: Import Blogroll from Sage'
aliases:
 - /2007/08/25/wordpress-import-blogroll-from-sage/
 - /2007/08/25/wordpress-import-blogroll-from-sage.html
---
Earlier today i exported the list with blogs i read from [Sage](http://sage.mozdev.org/) and tried to import them into [WordPress](http://wordpress.org). Although all the entries had been processed but none of them appeared. Apparently you have to rename the xmlUrl attribute to htmlUrl in the [OPML](http://en.wikipedia.org/wiki/OPML) file. With Vim that's as simple as ":%s/xmlUrl/htmlUrl/g".

Anyway, feel free to see if you find anything interesting in the [list of blogs i'm reading](http://www.timvw.be/wp-links-opml.php).
