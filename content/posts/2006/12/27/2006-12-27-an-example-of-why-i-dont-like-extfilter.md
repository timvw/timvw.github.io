---
date: "2006-12-27T00:00:00Z"
tags:
- PHP
title: An example of why i don't like the ext/filter API
aliases:
 - /2006/12/27/an-example-of-why-i-dont-like-extfilter/
 - /2006/12/27/an-example-of-why-i-dont-like-extfilter.html
---
Earlier this week i decided to experiment with the [Filter](http://be2.php.net/manual/en/function.filter-input.php) functions. Here's an example that illustrates why i think the API needs to be improved

```php
<?php
$isgoodapi = filter_input(INPUT_GET, 'isgoodapi', FILTER_VALIDATE_BOOLEAN);

if (is_null($isgoodapi)) {
 echo "the 'isgoodapi' argument is missing.";
} else if ($isgoodapi === FALSE) {
 echo "The 'isgoodapi' argument must be a valid boolean.";
} else {
 echo "isgoodapi is: $isgoodapi.";
}
?>
```

And now you request the page with ?isgoodapi=false. The obvious problem is the fact that the function returns multiple 'sorts' of return values: Value of the requested variable on success, FALSE if the filter fails, or NULL if the variable\_name variable is not set. If the flag FILTER\_NULL\_ON\_FAILURE is used, it returns FALSE if the variable is not set and NULL if the filter fails.

The documentation for [Filter Functions](http://be2.php.net/manual/en/ref.filter.php) says for FILTER\_VALIDATE\_BOOLEAN: Returns TRUE for "1", "true", "on" and "yes", FALSE for "0", "false", "off", "no", and "", NULL otherwise. So if you try with ?isgoodapi=konijn you would expect NULL but that isn't the case either.
