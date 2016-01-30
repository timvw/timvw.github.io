---
ID: 105
post_title: Generating JavaScript strings
author: timvw
post_date: 2005-07-29 02:05:02
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/07/29/generating-javascript-strings/
published: true
---
<p>Well, I've always experienced the generating JavaScript strings with PHP as a PITA. An example, which requires you to take care of the escaping of quotes, is the string: 'O'Reilly has nice books'. Today i had this brilliant idea to do it as following:</p>
[code lang="php"]<?php
$str = addslashes("Hello peter's cats");
echo "<script type='text/javascript'>";
echo "alert('$str')";
echo "";
?>[/code]