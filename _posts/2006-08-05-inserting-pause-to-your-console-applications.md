---
ID: 23
post_title: >
  Inserting pause to your Console
  Applications
author: timvw
post_date: 2006-08-05 02:25:19
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/08/05/inserting-pause-to-your-console-applications/
published: true
---
<p>When i write Console Applications i find myself to write the following two lines quite often:</p>
[code lang="csharp"]
Console.Write("{0}Press any key to continue...", Environment.NewLine);
Console.ReadKey();
[/code]
<p>As you already know i'm lazy so i decided to write an <a href="http://msdn2.microsoft.com/en-us/library/ms165392.aspx">IntelliSense Code Snippet</a>. When i type "pau" Intellisense show the following:</p>
<img src="http://www.timvw.be/wp-content/images/intellisense-drop-down-list.jpg" alt="Intellisense drop down list"/>
<p>Next i hit the tab button twice and i get the following effect:</p>
<img src="http://www.timvw.be/wp-content/images/intellisense-code-snippet.jpg" alt="Intellisense code snippet"/>
<p>Download <a href="http://www.timvw.be/wp-content/code/csharp/pause.txt">pause.txt</a> and save it as Pause.snippet in your %My DocumentS\Visual Studio 2005\Code Snippets\Visual C#\My Code Snippets% folder.</p>
<p>I've made it even simpler, you can install the snippet by simply running the <a href="http://www.timvw.be/wp-content/code/csharp/pause.vsi">pause.vsi</a> package (Visual Studio Installer).</p>