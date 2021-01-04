---
date: "2005-11-14T00:00:00Z"
tags:
- Perl
title: Parsing http headers
---
Today i updated my HTTP proxy a little. [RFC 2616](http://www.w3.org/Protocols/rfc2616/rfc2616.html) describes [Message Headers](http://www.w3.org/Protocols/rfc2616/rfc2616-sec4.html#sec4.2) as following:

> <div>
>   <pre>
message-header = field-name ":" [ field-value ]
field-name     = token
field-value    = *( field-content | LWS )
field-content  = &lt;the OCTETs making up the field-value and consisting of
                 either *TEXT or combinations of token, separators,
                 and quoted-string&gt;
</pre>
> </div>

Here is the code i used to get the field-name and field-value. Do you see the bug?

```perl
my ($name, $value) = split /:/, $in;
```

Location headers look like 'header: http://www.example.com'. Now, the problem is that [split](http://perldoc.perl.org/functions/split.html) returns a list with 'location', 'http' and 'www.example.com'. Here is the solution:

```perl 
my $in = 'location: http://www.example.com';
my ($name, $value) = split /:/, $in, 2;
```
