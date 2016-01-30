---
ID: 120
post_title: How private is private really?
author: timvw
post_date: 2006-01-12 02:43:29
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/01/12/how-private-is-private-really/
published: true
---
<p>Today i ended up at <a href="http://derickrethans.nl/private_properties_exposed.php">private properties exposed</a> (Apparently it's also used by <a href="http://www.phpunit.de/en/index.php">PHPUnit</a>)</p>
<pre>
class foo {
 private $bar = 42;
}

$obj = new foo;
$propname="\0foo\0bar";
$a = (array) $obj;
echo $a[$propname];
</pre>