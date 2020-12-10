---
title: Presenting AssemblyTypePicker
layout: post
guid: http://www.timvw.be/?p=476
tags:
  - 'C#'
  - Windows Forms
---
I really like the way the [Object Browser](http://msdn.microsoft.com/en-us/library/exy1facf(VS.80).aspx) makes the types in an assembly visible. Because i have a couple of programs that require a given type as input, i have decided to add a TypeTree control to [BeTimvwFramework](http://www.codeplex.com/BeTimvwFramework) that mimicks the Object Browser. Here are a couple of screenshots of the control in a demo application that allows the user to generate interfaces and wrapper classes based on a selected type:

![screenshot of assemblytypepicker with no values](http://www.timvw.be/wp-content/images/codegenerator_01.gif)
  

  
![screenshot of dialog that requests the user to pick an assembly file](http://www.timvw.be/wp-content/images/codegenerator_02.gif)
  

  
![screenshot of dialog that requests the user to pick a type in the previously selected assembly](http://www.timvw.be/wp-content/images/codegenerator_03.gif)

Feel free to download [CodeGenerator.zip](http://www.timvw.be/wp-content/code/csharp/CodeGenerator.zip).
