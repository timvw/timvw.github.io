---
id: 20
title: Dynamic CSS with PHP
date: 2006-08-27T02:13:40+00:00
author: timvw
layout: post
guid: http://www.timvw.be/dynamic-css-with-php/
permalink: /2006/08/27/dynamic-css-with-php/
dsq_thread_id:
  - 1926052835
tags:
  - PHP
---
Both html and css are simply text. Thus you should be able to generate css as easily as html with php. Now if you add a reference to the css.php file in your html (eg: <link rel="stylesheet" href="http://example.com/css.php" type="text/css" media="screen" />) you'll probably experience that your browser ignores the file. How is this possible? Here is an example of a simple css.php file

```php
body {
background-color: <?php echo 'yellow'; ?>;
}
```

Here is a simulation of what your browser recieves when it requests the file:

<pre>HTTP/1.1 200 OK
Date: Sat, 26 Aug 2006 23:36:21 GMT
Server: Apache/1.3.34 (Unix) PHP/4.4.2 mod_macro/1.1.2
X-Powered-By: PHP/4.4.2
Connection: close
Content-Type: text/html; charset=iso-8859-1

body {
        background-color: yellow;
}
</pre>

Where did that content-type header come from? Well, php outputs a default content-type header (text/html) when you don't set value explicitely. This means that your browser will try to interpret the file as html instead of css. Although it may seem weird, this behaviour is explicitely defined in [RFC 2616](http://www.w3.org/Protocols/rfc2616/rfc2616-sec7.html#sec7.2.1).

So the solution is pretty simple: explicitely generate content-type header. Here is an example for css: (You're smart enough to figure it out for csv, m3u, ...)

```php
<?php header('Content-type: text/css');?>


body {
background-color: <?php echo 'white'; ?>


}
```
