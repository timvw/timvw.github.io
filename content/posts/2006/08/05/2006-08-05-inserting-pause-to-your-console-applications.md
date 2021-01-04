---
date: "2006-08-05T00:00:00Z"
tags:
- CSharp
- Visual Studio
title: Inserting pause to your Console Applications
---
When i write Console Applications i find myself to write the following two lines quite often

```csharp
Console.Write("{0}Press any key to continue...", Environment.NewLine);
Console.ReadKey();
```

As you already know i'm lazy so i decided to write an [IntelliSense Code Snippet](http://msdn2.microsoft.com/en-us/library/ms165392.aspx). When i type "pau" Intellisense show the following:

![Intellisense drop down list](http://www.timvw.be/wp-content/images/intellisense-drop-down-list.jpg)

Next i hit the tab button twice and i get the following effect:

![Intellisense code snippet](http://www.timvw.be/wp-content/images/intellisense-code-snippet.jpg)

Download [pause.txt](http://www.timvw.be/wp-content/code/csharp/pause.txt) and save it as Pause.snippet in your %My DocumentS\Visual Studio 2005\Code Snippets\Visual C#\My Code Snippets% folder.

I've made it even simpler, you can install the snippet by simply running the [pause.vsi](http://www.timvw.be/wp-content/code/csharp/pause.vsi) package (Visual Studio Installer).
