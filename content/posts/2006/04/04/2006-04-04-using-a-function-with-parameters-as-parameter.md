---
date: "2006-04-04T00:00:00Z"
tags:
- JavaScript
title: Using a function with parameters as parameter
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
