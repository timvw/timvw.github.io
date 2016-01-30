---
ID: 47
post_title: tweaking Oracle SQL Developer
author: timvw
post_date: 2006-08-27 20:10:44
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/08/27/tweaking-oracle-sql-developer/
published: true
---
<p>A couple of days ago i discovered <a href="http://www.oracle.com/technology/products/database/sql_developer/index.html">Oracle SQL Developer</a>, a new and free graphical tool for database development. At first i was impressed by all it's features but when i tried to modify a couple of existing stored procedures the application freezed. <a href="http://forums.oracle.com/forums/profile.jspa?userID=481264">EricH</a> directed me to the <a href="http://www.oracle.com/technology/products/database/sql_developer/files/faqs.html#q3">FAQ: Can I suppress Code Insight (and why would I want to)?</a>. Now that i have added the 'AddVMOption -J-Dsdev.insight=false' to my sqldeveloper.conf the application runs smooth</p>
<a href="http://www.timvw.be/wp-content/images/oraclesqldeveloper-large.jpg"><img src="http://www.timvw.be/wp-content/images/oraclesqldeveloper-small.jpg" alt="screenshot of oracle sqldeveloper"/></a>