---
ID: 34
post_title: >
  Internationalizing strings with
  variables
author: timvw
post_date: 2006-03-19 02:47:03
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/03/19/internationalizing-strings-with-variables/
published: true
---
<p>Yesterday i wrote that you can use __($string, $domain) and _e($string, $domain) to internationalize a string with <a href="http://www.wordpress.org">WordPress</a>. I forgot to mention that if you use <a href="http://www.php.net/sprintf">sprintf</a> you can handle strings with variables too. An example:</p>
[code lang="php"]
echo sprintf(__('There are %d monkeys in the %s'), $domain), $number, $location);
[/code]