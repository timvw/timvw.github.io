---
id: 47
title: tweaking Oracle SQL Developer
date: 2006-08-27T20:10:44+00:00
author: timvw
layout: post
guid: http://www.timvw.be/tweaking-oracle-sql-developer/
permalink: /2006/08/27/tweaking-oracle-sql-developer/
tags:
  - SQL
---
A couple of days ago i discovered [Oracle SQL Developer](http://www.oracle.com/technology/products/database/sql_developer/index.html), a new and free graphical tool for database development. At first i was impressed by all it's features but when i tried to modify a couple of existing stored procedures the application freezed. [EricH](http://forums.oracle.com/forums/profile.jspa?userID=481264) directed me to the [FAQ: Can I suppress Code Insight (and why would I want to)?](http://www.oracle.com/technology/products/database/sql_developer/files/faqs.html#q3). Now that i have added the 'AddVMOption -J-Dsdev.insight=false' to my sqldeveloper.conf the application runs smooth

[![screenshot of oracle sqldeveloper](http://www.timvw.be/wp-content/images/oraclesqldeveloper-small.jpg)](http://www.timvw.be/wp-content/images/oraclesqldeveloper-large.jpg)
