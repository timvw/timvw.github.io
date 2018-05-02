---
id: 113
title: Passing a filehandle as parameter
date: 2005-10-20T02:23:25+00:00
author: timvw
layout: post
guid: http://www.timvw.be/passing-a-filehandle-as-parameter/
permalink: /2005/10/20/passing-a-filehandle-as-parameter/
dsq_thread_id:
  - 1926900865
tags:
  - Perl
---
To keep things maintainable we split our program in modules, classes, functions... In [perlsub](http://perldoc.perl.org/perlsub.html) from the execellent perl documentation you can lookup the syntax of how to use functions. Offcourse, you have to digg pretty deep to find out how you can pass a filehandle

```perl
# clientproc(*STDOUT);
# pass the socket
clientproc(*CH);

sub clientproc  
{
  $fh = shift;  
  print $fh 'hello world';
}
```
