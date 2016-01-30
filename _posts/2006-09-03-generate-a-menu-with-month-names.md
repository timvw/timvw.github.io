---
ID: 18
post_title: Generate a menu with month names
author: timvw
post_date: 2006-09-03 02:11:21
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/09/03/generate-a-menu-with-month-names/
published: true
---
<p>I still see people building their calendar control or month (or day) picker with a hardcoded array of month (or day) names. With the use of <a href="http://www.php.net/strftime">strftime</a> you can easily build a <a href="http://www.php.net/setlocale">locale aware</a> version. Here is an example:</p>
[code lang="php"]<?php
function SelectMonths($name = 'selectMonths', $id = 'selectMonths') {
 $current_month = date('n');

 echo '<select name="' . $name .'" id="' . $id . '">';

 for ($i = 1; $i < 13; ++$i) {
  echo '<option value="' . $i . '"';

  if ($i == $current_month) {
   echo ' selected';
  }

 $month_name = strftime('%B', mktime(0, 0, 0, $i, 1, 2006));

  echo '>' . $month_name . '</option>';
 }

 echo '</select>';
}
?>[/code]
<p>And now you can easily generate a localized menu:</p>
[code lang="php"]<?php
include('SelectMonths.php');

SelectMonths();

// Tested on a Windows host - Read the http://be.php.net/setlocale
setlocale(LC_TIME, 'dutch');
SelectMonths();
?>[/code]