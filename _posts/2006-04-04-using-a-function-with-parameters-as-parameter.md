---
ID: 33
post_title: >
  Using a function with parameters as
  parameter
author: timvw
post_date: 2006-04-04 02:46:09
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/04/04/using-a-function-with-parameters-as-parameter/
published: true
---
<p>Imagine that you have a function that expects a reference to a function. Here is an example of such a function:</p>

[code lang="javascript"]
function bar(fn) { fn(); }
[/code]

<p>Now imagine that the function that you want to pass to bar accepts a parameter. Here is an example of such a function:</p>

[code lang="javascript"]
function foo(arg) { alert(arg); }
[/code]

<p>With the help of a closure this is no problem:</p>

[code lang="javascript"]
bar(function e() { foo('hello'); });
[/code]

<p>PS: <a href="http://forums.devnetwork.net/viewtopic.php?t=46561">Kudos</a> go to <a href="http://forums.devnetwork.net/profile.php?mode=viewprofile&u=7815">Weirdan</a> for providing the solution to this problem.</p>