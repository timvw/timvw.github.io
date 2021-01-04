---
date: "2006-09-03T00:00:00Z"
tags:
- PHP
title: Generate a menu with month names
---
I still see people building their calendar control or month (or day) picker with a hardcoded array of month (or day) names. With the use of [strftime](http://www.php.net/strftime) you can easily build a [locale aware](http://www.php.net/setlocale) version. Here is an example

```php
<?php
function SelectMonths($name = 'selectMonths', $id = 'selectMonths') {
 $current_month = date('n');

 echo '<select name="' . $name .'" id="' . $id . '">';

for ($i = 1; $i < 13; ++$i) { echo '<option value="' . $i . '"'; if ($i == $current\_month) { echo ' selected'; } $month\_name = strftime('%B', mktime(0, 0, 0, $i, 1, 2006)); echo '>' . $month_name . '</option>';
}

echo '</select>';
}
?>
```

And now you can easily generate a localized menu

```php
<?php
include('SelectMonths.php');

SelectMonths();

// Tested on a Windows host - Read the http://be.php.net/setlocale
setlocale(LC_TIME, 'dutch');
SelectMonths();
?>
```
