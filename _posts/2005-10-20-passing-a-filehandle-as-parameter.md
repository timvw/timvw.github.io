---
title: Passing a filehandle as parameter
layout: post
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
