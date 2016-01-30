---
ID: 830
post_title: 'JavaScript: The Good Parts'
author: timvw
post_date: 2009-02-13 08:59:10
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/02/13/javascript-the-good-parts/
published: true
---
<p>This week i have been reading <a href="http://www.amazon.com/JavaScript-Good-Parts-Douglas-Crockford/dp/0596517742">JavaScript: The Good Parts</a>. Although the book is pretty thin, approximitaly. 150 pages, the information that is inside the book is really powerful. The book provides deep insight for people that are considering to implement functionality in JavaScript. I would say that this is a must read.</p>

<p>Here is an example of something that i learned from the book (A workaround for an error in the ECMAScript Language Specification which causes this to be set incorrectly for inner functions):</p>

[code lang="javascript"]function Broken(name) {
 this.name = name;
 function GetName() { return this.name; }
 this.Display = function() { alert(GetName()); }
}

new Broken("broken").Display(); // displays 'undefined'[/code]

&nbsp;

[code lang="javascript"]function Fixed(name) {
 var that = this;
 this.name = name;

  function GetName() { return that.name; }
  this.Display = function() { alert(GetName()); }
}

new Fixed("fixed").Display(); // displays 'fixed'[/code]