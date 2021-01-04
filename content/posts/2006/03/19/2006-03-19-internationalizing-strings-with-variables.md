---
date: "2006-03-19T00:00:00Z"
tags:
- WordPress
title: Internationalizing strings with variables
---
Yesterday i wrote that you can use __($string, $domain) and _e($string, $domain) to internationalize a string with [WordPress](http://www.wordpress.org). I forgot to mention that if you use [sprintf](http://www.php.net/sprintf) you can handle strings with variables too. An example:

```php
echo sprintf(__('There are %d monkeys in the %s'), $domain), $number, $location);
```
