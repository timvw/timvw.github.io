---
date: "2005-07-29T00:00:00Z"
tags:
- PHP
title: Generating JavaScript strings
aliases:
 - /2005/07/29/generating-javascript-strings/
 - /2005/07/29/generating-javascript-strings.html
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
