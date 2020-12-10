---
title: Changing the include_path
layout: post
tags:
  - PHP
---
PHP has a feature to change the [include_path](http://www.php.net/manual/en/ini.core.php#ini.include-path) programatically. The problem is that the path separator is : on unix and ; on windows. Luckily there is a constant [PATH_SEPARATOR](http://www.php.net/manual/en/reserved.constants.php) to overcome this issue. Here is how i would do it

```php
<?php
ini_set('error_reporting', E_ALL);
ini_set('display_errors', TRUE);

$include_paths = array(
  '.',
  '/home/users/timvw/phpincs',
  '/home/users/timvw/pear',
  ini_get('include_path')
);

ini_set('include_path', implode(PATH_SEPARATOR, $include_paths));

?>
```
