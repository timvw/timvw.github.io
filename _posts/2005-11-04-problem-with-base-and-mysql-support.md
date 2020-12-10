---
title: Problem with Base and MySQL support
layout: post
tags:
  - Free Software
---
Today i decided to try out the new [OpenOffice.org](http://www.openoffice.org/) release. Creating a presentation with [Impress](http://www.openoffice.org/product/impress.html) went pretty smooth. After that i wanted to check out [Base](http://www.openoffice.org/product/base.html) with a MySQL backend but i got an error message that the JDBC driver could not be loaded. 


![Could not load JDBC driver dialog](http://www.timvw.be/wp-content/images/ooo2mysqlfail.jpg) 

I immediately knew that i had to add the [MySQL driver](http://www.mysql.com/products/connector/j/) to the classpath. A little websearch learned me i have to choose Tools->Options in the menu. And from there i can modify the classpath via the OpenOffice.org->Java panel.


<img src="http://www.timvw.be/wp-content/images/ooo2mysqljava.jpg" alt="Java configuration dialog" width="470" /> 


![Add MySQL Connector/J to classpath dialog](http://www.timvw.be/wp-content/images/ooo2mysqladd.jpg) 


![Could load JDBC driver dialog](http://www.timvw.be/wp-content/images/ooo2mysqlsuccess.jpg) 

After that everything went smooth 🙂 There are so many sites talking about the new release and all the new features but none of them seem to have experienced this. It makes me wonder if they have really tried it out..
