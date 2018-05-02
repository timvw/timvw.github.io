---
id: 120
title: How private is private really?
date: 2006-01-12T02:43:29+00:00
author: timvw
layout: post
guid: http://www.timvw.be/how-private-is-private-really/
permalink: /2006/01/12/how-private-is-private-really/
tags:
  - PHP
---
Today i ended up at [private properties exposed](http://derickrethans.nl/private_properties_exposed.php) (Apparently it is also used by [PHPUnit](http://www.phpunit.de/en/index.php))

```php
class foo {
 private $bar = 42;
}

$obj = new foo;
$propname="\0foo\0bar";
$a = (array) $obj;
echo $a[$propname];
```
