---
ID: 611
post_title: >
  Presenting templates for int and string
  ValueObjects
author: timvw
post_date: 2008-09-26 17:01:30
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/09/26/presenting-templates-for-int-and-string-valueobjects/
published: true
---
<p>Most <a href="http://domaindrivendesign.org/discussion/messageboardarchive/ValueObjects.html">ValueObjects</a> that i have implemented were wrappers around an int or a string. Apart from the domain specific rules, there is a lot of repetitive work in implementing operator overloads, IEquatable&lt;T&gt;, IComparable&lt;T&gt;, ... Thus i decided to create a couple of Item templates that generate this code (and related tests).</p>
<p>Simply save <a href="http://www.timvw.be/wp-content/code/csharp/IntValueObject.zip">IntValueObject.zip</a> and <a href="http://www.timvw.be/wp-content/code/csharp/StringValueObject.zip">StringValueObject.zip</a> under %My Documents%\Visual Studio 2005\Templates\ItemTemplates and click on "Add New Item" in your project:</p>

<img src="http://www.timvw.be/wp-content/images/template_add_new_item.gif" alt="screenshot of add new item dialog in visual studio"/>

<p>Add the bottom of the dialog you can choose one of the templates:</p>

<img src="http://www.timvw.be/wp-content/images/template_my_templates.gif" alt="screenshot of add new item dialog in visual studio"/>

<p>Here is the result of adding an <a href="http://en.wikipedia.org/wiki/International_Standard_Book_Number">International Standard Book Number</a> class:</p>

<img src="http://www.timvw.be/wp-content/images/template_isbn.gif" alt="screenshot of generated artificates for isbn"/>