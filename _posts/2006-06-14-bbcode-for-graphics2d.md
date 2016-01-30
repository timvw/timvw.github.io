---
ID: 25
post_title: BBCode for Graphics2D
author: timvw
post_date: 2006-06-14 02:34:06
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/06/14/bbcode-for-graphics2d/
published: true
---
<p>For my graduation project we needed the ability to print a couple of bills etc. Printing lines was pretty simple with the <a href="http://www.timvw.be/wp-content/code/java/LinesPrinter.java.txt">LinesPrinter</a> i blogged about a while ago. We had two choices: either implement a specific <a href="http://java.sun.com/j2se/1.5.0/docs/api/java/awt/print/Printable.html#print(java.awt.Graphics,%20java.awt.print.PageFormat,%20int)">print method</a> for each module or implement a reusable markup system. Obviously we went for the second option and came up with something alike <a href="http://en.wikipedia.org/wiki/BBCode">BBCode</a>. The codes we implemented are:</p>

<ul>
<li>[b]..[/b] for bold</li>
<li>[i]..[/i] for italic</li>
<li>[color=x]..[/color] for color x</li>
<li>[c]..[/c] for centered text</li>
<li>[r]..[/r] for right aligned text</li>
<li>[ll=x]..[/ll] for left aligned text starting from the x-th column at the left</li>
<li>[lr=x]..[/lr] for left aligned text starting from the x-th column at the right</li>
<li>[rl=x]..[/ll] for right aligned text starting from the x-th column at the left</li>
<li>[rr=x]..[/ll] for right aligned text starting from the x-th column at the right</li>
</ul>

<p>Since the code is written to work on a <a href="http://java.sun.com/j2se/1.5.0/docs/api/java/awt/Graphics2D.html">Graphics2D</a> device you can also render the formatted text on a jpanel etc instead of a printer device. Here is a screenshot of a generated bill (on a jpanel):</p>

<img src="http://www.timvw.be/wp-content/images/rpcode.png" alt="rpcode"/>

<p>Feel free to download, try and improve the <a href="http://www.timvw.be/wp-content/code/java/rpcode.zip">rpcode.zip</a> package.</p>