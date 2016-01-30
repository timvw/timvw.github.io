---
ID: 476
post_title: Presenting AssemblyTypePicker
author: timvw
post_date: 2008-09-01 17:32:27
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/09/01/presenting-assemblytypepicker/
published: true
---
<p>I really like the way the <a href="http://msdn.microsoft.com/en-us/library/exy1facf(VS.80).aspx">Object Browser</a> makes the types in an assembly visible. Because i have a couple of programs that require a given type as input, i have decided to add a TypeTree control to <a href="http://www.codeplex.com/BeTimvwFramework">BeTimvwFramework</a> that mimicks the Object Browser. Here are a couple of screenshots of the control in a demo application that allows the user to generate interfaces and wrapper classes based on a selected type:</p>

<img src="http://www.timvw.be/wp-content/images/codegenerator_01.gif" alt="screenshot of assemblytypepicker with no values" />
<br/>
<img src="http://www.timvw.be/wp-content/images/codegenerator_02.gif" alt="screenshot of dialog that requests the user to pick an assembly file"/>
<br/>
<img src="http://www.timvw.be/wp-content/images/codegenerator_03.gif" alt="screenshot of dialog that requests the user to pick a type in the previously selected assembly"/>

<p>Feel free to download <a href="http://www.timvw.be/wp-content/code/csharp/CodeGenerator.zip">CodeGenerator.zip</a>.</p>