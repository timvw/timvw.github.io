---
ID: 122
post_title: Problem with Base and MySQL support
author: timvw
post_date: 2005-11-04 02:52:02
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/11/04/problem-with-base-and-mysql-support/
published: true
---
<p>
Today i decided to try out the new <a href="http://www.openoffice.org/">OpenOffice.org</a>  release. Creating a presentation with <a href="http://www.openoffice.org/product/impress.html">Impress</a> went pretty smooth. After that i wanted to check out <a href="http://www.openoffice.org/product/base.html">Base</a> with a MySQL backend but i got an error message that the JDBC driver could not be loaded.
</p>

<p>
<img src="http://www.timvw.be/wp-content/images/ooo2mysqlfail.jpg" alt="Could not load JDBC driver dialog" />
</p>

<p>I immediately knew that i had to add the <a href="http://www.mysql.com/products/connector/j/">MySQL driver</a> to the classpath. A little websearch learned me i have to choose Tools->Options in the menu. And from there i can modify the classpath via the OpenOffice.org->Java panel.</p>

<p>
<img src="http://www.timvw.be/wp-content/images/ooo2mysqljava.jpg" alt="Java configuration dialog" width="470" />
</p>

<p>
<img src="http://www.timvw.be/wp-content/images/ooo2mysqladd.jpg" alt="Add MySQL Connector/J to classpath dialog" />
</p>

<p>
<img src="http://www.timvw.be/wp-content/images/ooo2mysqlsuccess.jpg" alt="Could load JDBC driver dialog" />
</p>


<p>
After that everything went smooth :) There are so many sites talking about the new release and all the new features but none of them seem to have experienced this. It makes me wonder if they have really tried it out..
</p>