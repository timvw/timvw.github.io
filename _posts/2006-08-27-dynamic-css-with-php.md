---
ID: 20
post_title: Dynamic CSS with PHP
author: timvw
post_date: 2006-08-27 02:13:40
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/08/27/dynamic-css-with-php/
published: true
dsq_thread_id:
  - "1926052835"
---
<p>Both html and css are simply text. Thus you should be able to generate css as easily as html with php. Now if you add a reference to the css.php file in your html (eg: &lt;link rel="stylesheet" href="http://example.com/css.php" type="text/css" media="screen" /&gt;) you'll probably experience that your browser ignores the file. How is this possible? Here is an example of a simple css.php file</p>

[code lang="php"]body {
        background-color: <?php echo 'yellow'; ?>;
}[/code]

<p>Here is a simulation of what your browser recieves when it requests the file:</p>

<pre>
HTTP/1.1 200 OK
Date: Sat, 26 Aug 2006 23:36:21 GMT
Server: Apache/1.3.34 (Unix) PHP/4.4.2 mod_macro/1.1.2
X-Powered-By: PHP/4.4.2
Connection: close
Content-Type: text/html; charset=iso-8859-1

body {
        background-color: yellow;
}
</pre>

<p>Where did that content-type header come from? Well, php outputs a default content-type header (text/html) when you don't set value explicitely. This means that your browser will try to interpret the file as html instead of css. Although it may seem weird, this behaviour is explicitely defined in <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec7.html#sec7.2.1">RFC 2616</a>.</p>

<p>So the solution is pretty simple: explicitely generate content-type header. Here is an example for css: (You're smart enough to figure it out for csv, m3u, ...)</p>

[code lang="php"]<?php header('Content-type: text/css');?>
body {
  background-color: <?php echo 'white'; ?>
}
[/code]