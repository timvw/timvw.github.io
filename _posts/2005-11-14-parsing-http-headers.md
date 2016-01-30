---
ID: 65
post_title: Parsing http headers
author: timvw
post_date: 2005-11-14 21:42:37
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/11/14/parsing-http-headers/
published: true
---
<p>Today i updated my HTTP proxy a little. <a href="http://www.w3.org/Protocols/rfc2616/rfc2616.html">RFC 2616</a> describes <a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec4.html#sec4.2">Message Headers</a> as following:</p>

<blockquote>
<div>
<pre>
message-header = field-name ":" [ field-value ]
field-name     = token
field-value    = *( field-content | LWS )
field-content  = &lt;the OCTETs making up the field-value and consisting of
                 either *TEXT or combinations of token, separators,
                 and quoted-string&gt;
</pre>
</div>
</blockquote>

<p>Here is the code i used to get the field-name and field-value. Do you see the bug?</p>
[code lang="perl"]
my ($name, $value) = split /:/, $in;
[/code]

<p>Location headers look like "header: http://www.example.com". Now, the problem is that <a href="http://perldoc.perl.org/functions/split.html">split</a> returns a list with "location", "http" and "www.example.com". Here is the solution:</p>

[code lang="perl"]
my $in = "location: http://www.example.com";
my ($name, $value) = split /:/, $in, 2;
[/code]