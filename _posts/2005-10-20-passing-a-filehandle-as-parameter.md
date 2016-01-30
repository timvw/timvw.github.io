---
ID: 113
post_title: Passing a filehandle as parameter
author: timvw
post_date: 2005-10-20 02:23:25
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/10/20/passing-a-filehandle-as-parameter/
published: true
dsq_thread_id:
  - "1926900865"
---
<p>To keep things maintainable we split our program in modules, classes, functions... In <a href="http://perldoc.perl.org/perlsub.html">perlsub</a>  from the execellent perl documentation you can lookup the syntax of how to use functions. Offcourse, you have to digg pretty deep to find out how you can pass a filehandle:</p>
[code lang="perl"]
# clientproc(*STDOUT);
# pass the socket
clientproc(*CH);

sub clientproc
{
  $fh = shift;
  print $fh "hello world";
}
[/code]