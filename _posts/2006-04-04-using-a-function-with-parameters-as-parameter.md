---
id: 33
title: Using a function with parameters as parameter
date: 2006-04-04T02:46:09+00:00
author: timvw
layout: post
guid: http://www.timvw.be/using-a-function-with-parameters-as-parameter/
permalink: /2006/04/04/using-a-function-with-parameters-as-parameter/
tags:
  - JavaScript
---
Imagine that you have a function that expects a reference to a function. Here is an example of such a function

```javascript
function bar(fn) { fn(); }
```

Now imagine that the function that you want to pass to bar accepts a parameter. Here is an example of such a function

```javascript
function foo(arg) { alert(arg); }
```

With the help of a closure this is no problem

```javascript
bar(function e() { foo('hello'); });
```

PS: [Kudos](http://forums.devnetwork.net/viewtopic.php?t=46561) go to [Weirdan](http://forums.devnetwork.net/profile.php?mode=viewprofile&u=7815) for providing the solution to this problem.