---
ID: 67
post_title: Changing the include_path
author: timvw
post_date: 2005-11-06 21:47:56
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/11/06/changing-the-include_path/
published: true
---
<p>PHP has a feature to change the <a href="http://www.php.net/manual/en/ini.core.php#ini.include-path">include_path</a> programatically. The problem is that the path separator is : on unix and ; on windows. Luckily there is a constant <a href="http://www.php.net/manual/en/reserved.constants.php">PATH_SEPARATOR</a> to overcome this issue. Here is how i would do it:</p>
[code lang="php"]<?php
ini_set('error_reporting', E_ALL);
ini_set('display_errors', TRUE);

$include_paths = array(
  '.',
  '/home/users/timvw/phpincs',
  '/home/users/timvw/pear',
  ini_get('include_path')
);

ini_set('include_path', implode(PATH_SEPARATOR, $include_paths));

?>[/code]