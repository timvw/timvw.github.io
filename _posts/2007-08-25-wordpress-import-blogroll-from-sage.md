---
ID: 195
post_title: 'WordPress: Import Blogroll from Sage'
author: timvw
post_date: 2007-08-25 22:54:15
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2007/08/25/wordpress-import-blogroll-from-sage/
published: true
---
<p>Earlier today i exported the list with blogs i read from <a href="http://sage.mozdev.org/">Sage</a> and tried to import them into <a href="http://wordpress.org">WordPress</a>. Although all the entries had been processed but none of them appeared. Apparently you have to rename the xmlUrl attribute to htmlUrl in the <a href="http://en.wikipedia.org/wiki/OPML">OPML</a> file. With Vim that's as simple as ":%s/xmlUrl/htmlUrl/g".</p>
<p>Anyway, feel free to see if you find anything interesting in the <a href="http://www.timvw.be/wp-links-opml.php">list of blogs i'm reading</a>.</p>