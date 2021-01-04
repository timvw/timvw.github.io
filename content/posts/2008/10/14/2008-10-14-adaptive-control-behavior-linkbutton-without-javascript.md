---
date: "2008-10-14T00:00:00Z"
guid: http://www.timvw.be/?p=688
tags:
- ASP.NET
- CSharp
title: "Adaptive control behavior: LinkButton without javascript"
---
'Experiment with [Adaptive Control Behavior](http://msdn.microsoft.com/en-us/library/67276kc5.aspx)' has been an item on my TO-DO list for a very long time and this weekend i finally found some time to do exactly that. Because i hate it that a [LinkButton](http://msdn.microsoft.com/en-us/library/system.web.ui.webcontrols.linkbutton.aspx) renders as <a href="javascript:__doPostBackxxx"> i decided to develop a [ControlAdapter](http://msdn.microsoft.com/en-us/library/system.web.ui.adapters.controladapter.aspx) that makes the LinkButton work without JavaScript. While i was at it i also wrote adapters for the [LoginStatus](http://msdn.microsoft.com/en-us/library/system.web.ui.webcontrols.loginstatus(VS.80).aspx) and [Login](http://msdn.microsoft.com/en-us/library/system.web.ui.webcontrols.login.aspx) controls. Feel free to play with the [Adaptive Rendering Demo](http://www.timvw.be/wp-content/code/csharp/AdaptiveRenderingDemo.zip).