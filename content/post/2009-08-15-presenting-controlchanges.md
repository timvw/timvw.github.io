---
date: "2009-08-15T00:00:00Z"
guid: http://www.timvw.be/?p=1163
tags:
- CSharp
- Windows Forms
title: Presenting ControlChanges
aliases:
 - /2009/08/15/presenting-controlchanges/
 - /2009/08/15/presenting-controlchanges.html
---
Because i noticed that i kept writing the same operations on control over and over again i decided to capture them in a couple of functions. I presume most of you have done this already. Here is the list of operations:

![screenshot of a class diagram with the following operations: MakeVisible, MakeInvisible and TheOnlyVisibleControlsAre.](http://www.timvw.be/wp-content/images/controlchanges.cd.png)

In case it is not clear what these methods should do i have defined the following specifications for them:

![screenshot of requirements list for controlchanges.](http://www.timvw.be/wp-content/images/controlchanges.specs.png)

Get the code here: [ControlChanges](http://www.timvw.be/wp-content/code/csharp/ControlChanges.cs.txt) and [WhenExecutingControlChanges](http://www.timvw.be/wp-content/code/csharp/WhenExecutingControlChanges.cs.txt). Stay tuned for more!
