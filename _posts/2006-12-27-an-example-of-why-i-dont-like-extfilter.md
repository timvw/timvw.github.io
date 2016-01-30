---
ID: 136
post_title: 'An example of why i don&#039;t like the ext/filter API'
author: timvw
post_date: 2006-12-27 03:11:30
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/12/27/an-example-of-why-i-dont-like-extfilter/
published: true
---
<p>Earlier this week i decided to experiment with the <a href="http://be2.php.net/manual/en/function.filter-input.php">Filter</a> functions. Here's an example that illustrates why i think the API needs to be improved:</p>
[code lang="php"]<?php
$isgoodapi = filter_input(INPUT_GET, 'isgoodapi', FILTER_VALIDATE_BOOLEAN);

if (is_null($isgoodapi)) {
 echo "the 'isgoodapi' argument is missing.";
} else if ($isgoodapi === FALSE) {
 echo "The 'isgoodapi' argument must be a valid boolean.";
} else {
 echo "isgoodapi is: $isgoodapi.";
}
?>[/code]
<p>And now you request the page with ?isgoodapi=false. The obvious problem is the fact that the function returns multiple 'sorts' of return values: Value of the requested variable on success, FALSE if the filter fails, or NULL if the variable_name variable is not set. If the flag FILTER_NULL_ON_FAILURE is used, it returns FALSE if the variable is not set and NULL if the filter fails.</p>
<p>The documentation for <a href="http://be2.php.net/manual/en/ref.filter.php">Filter Functions</a> says for FILTER_VALIDATE_BOOLEAN: Returns TRUE for "1", "true", "on" and "yes", FALSE for "0", "false", "off", "no", and "", NULL otherwise. So if you try with ?isgoodapi=konijn you would expect NULL but that isn't the case either.</p>