---
title: How private is private really?
layout: post
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
