---
date: "2005-10-20T00:00:00Z"
tags:
- Perl
title: Passing a filehandle as parameter
aliases:
 - /2005/10/20/passing-a-filehandle-as-parameter/
 - /2005/10/20/passing-a-filehandle-as-parameter.html
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
