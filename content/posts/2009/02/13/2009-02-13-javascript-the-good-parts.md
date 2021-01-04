---
date: "2009-02-13T00:00:00Z"
guid: http://www.timvw.be/?p=830
tags:
- Book reviews
title: 'JavaScript: The Good Parts'
---
This week i have been reading [JavaScript: The Good Parts](http://www.amazon.com/JavaScript-Good-Parts-Douglas-Crockford/dp/0596517742). Although the book is pretty thin, approximitaly. 150 pages, the information that is inside the book is really powerful. The book provides deep insight for people that are considering to implement functionality in JavaScript. I would say that this is a must read.

Here is an example of something that i learned from the book (A workaround for an error in the ECMAScript Language Specification which causes this to be set incorrectly for inner functions)

```javascript
function Broken(name) {
	this.name = name;
	function GetName() { return this.name; }
	this.Display = function() { alert(GetName()); }
}

new Broken("broken").Display(); // displays 'undefined'
```

and 

```javascript
function Fixed(name) {
	var that = this;
	this.name = name;
	function GetName() { return that.name; }
	this.Display = function() { alert(GetName()); }
}

new Fixed("fixed").Display(); // displays 'fixed'
```
