---
title: BBCode for Graphics2D
layout: post
tags:
  - Java
---
For my graduation project we needed the ability to print a couple of bills etc. Printing lines was pretty simple with the [LinesPrinter](http://www.timvw.be/wp-content/code/java/LinesPrinter.java.txt) i blogged about a while ago. We had two choices: either implement a specific [print method](http://java.sun.com/j2se/1.5.0/docs/api/java/awt/print/Printable.html#print(java.awt.Graphics,%20java.awt.print.PageFormat,%20int)) for each module or implement a reusable markup system. Obviously we went for the second option and came up with something alike [BBCode](http://en.wikipedia.org/wiki/BBCode). The codes we implemented are

* [b]..[/b] for bold
* [i]..[/i] for italic
* [color=x]..[/color] for color x
* [c]..[/c] for centered text
* [r]..[/r] for right aligned text
* [ll=x]..[/ll] for left aligned text starting from the x-th column at the left
* [lr=x]..[/lr] for left aligned text starting from the x-th column at the right
* [rl=x]..[/ll] for right aligned text starting from the x-th column at the left
* [rr=x]..[/ll] for right aligned text starting from the x-th column at the right

Since the code is written to work on a [Graphics2D](http://java.sun.com/j2se/1.5.0/docs/api/java/awt/Graphics2D.html) device you can also render the formatted text on a jpanel etc instead of a printer device. Here is a screenshot of a generated bill (on a jpanel):

![rpcode](http://www.timvw.be/wp-content/images/rpcode.png)

Feel free to download, try and improve the [rpcode.zip](http://www.timvw.be/wp-content/code/java/rpcode.zip) package.
