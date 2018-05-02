---
id: 105
title: Generating JavaScript strings
date: 2005-07-29T02:05:02+00:00
author: timvw
layout: post
guid: http://www.timvw.be/generating-javascript-strings/
permalink: /2005/07/29/generating-javascript-strings/
tags:
  - PHP
---
Well, I've always experienced the generating JavaScript strings with PHP as a PITA. An example, which requires you to take care of the escaping of quotes, is the string: 'O'Reilly has nice books'. Today i had this brilliant idea to do it as following:

```php
<?php
$str = addslashes("Hello peter's cats");
echo "<script type='text/javascript'>";
echo "alert('$str')";
echo "";
?>
```
