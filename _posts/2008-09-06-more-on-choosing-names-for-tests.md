---
ID: 507
post_title: More on choosing names for tests
author: timvw
post_date: 2008-09-06 12:10:19
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/09/06/more-on-choosing-names-for-tests/
published: true
---
<p>Choosing names with the <a href="http://www.timvw.be/experimenting-with-naming-conventions-for-unit-tests/">technique i presented yesterday</a> leads to at least one class per method. To tackle that explosion of classes i have made two decisions:</p>

<ol>
<li>Add a folder for each tested class, this way all the When&lt;MethodName&gt;ing classes are grouped.</li>
<li>Create a single WhenUsing&lt;ClassName&gt; class to group simple test methods.</li>
</ol>

<p>Here is a screenshot to clarify the changes:</p>

<img src="http://www.timvw.be/wp-content/images/unittest_naming_conventions2.gif" alt="screenshot of visual studio displaying new approach for test naming"/>