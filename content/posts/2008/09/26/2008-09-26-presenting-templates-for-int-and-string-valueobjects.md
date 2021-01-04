---
date: "2008-09-26T00:00:00Z"
guid: http://www.timvw.be/?p=611
tags:
- CSharp
- Visual Studio
title: Presenting templates for int and string ValueObjects
---
Most [ValueObjects](http://domaindrivendesign.org/discussion/messageboardarchive/ValueObjects.html) that i have implemented were wrappers around an int or a string. Apart from the domain specific rules, there is a lot of repetitive work in implementing operator overloads, IEquatable<T>, IComparable<T>, ... Thus i decided to create a couple of Item templates that generate this code (and related tests).

Simply save [IntValueObject.zip](http://www.timvw.be/wp-content/code/csharp/IntValueObject.zip) and [StringValueObject.zip](http://www.timvw.be/wp-content/code/csharp/StringValueObject.zip) under %My Documents%\Visual Studio 2005\Templates\ItemTemplates and click on "Add New Item" in your project:

![screenshot of add new item dialog in visual studio](http://www.timvw.be/wp-content/images/template_add_new_item.gif)

Add the bottom of the dialog you can choose one of the templates:

![screenshot of add new item dialog in visual studio](http://www.timvw.be/wp-content/images/template_my_templates.gif)

Here is the result of adding an [International Standard Book Number](http://en.wikipedia.org/wiki/International_Standard_Book_Number) class:

![screenshot of generated artificates for isbn](http://www.timvw.be/wp-content/images/template_isbn.gif)
