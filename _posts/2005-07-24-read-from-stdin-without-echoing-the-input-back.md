---
ID: 102
post_title: >
  Read from STDIN without echoing the
  input back
author: timvw
post_date: 2005-07-24 01:57:14
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/07/24/read-from-stdin-without-echoing-the-input-back/
published: true
---
<p>Today i was looking for a way to read passwords from a PHP-CLI script. So it was important the password didn't appear on the console. I wrote a <a href="http://www.timvw.be/wp-content/code/php/ttyecho.php.txt">ttyecho function</a> that uses <a href="http://unixhelp.ed.ac.uk/CGI/man-cgi?stty">stty</a> to change the terminal line settings.</p>