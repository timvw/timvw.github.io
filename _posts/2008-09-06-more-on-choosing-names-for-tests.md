---
id: 507
title: More on choosing names for tests
date: 2008-09-06T12:10:19+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=507
permalink: /2008/09/06/more-on-choosing-names-for-tests/
tags:
  - Information Technology
---
Choosing names with the [technique i presented yesterday](http://www.timvw.be/experimenting-with-naming-conventions-for-unit-tests/) leads to at least one class per method. To tackle that explosion of classes i have made two decisions:

  1. Add a folder for each tested class, this way all the When<MethodName>ing classes are grouped.
  2. Create a single WhenUsing<ClassName> class to group simple test methods.

Here is a screenshot to clarify the changes:

![screenshot of visual studio displaying new approach for test naming](http://www.timvw.be/wp-content/images/unittest_naming_conventions2.gif)
