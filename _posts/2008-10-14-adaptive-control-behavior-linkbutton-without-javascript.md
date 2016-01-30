---
ID: 688
post_title: 'Adaptive control behavior: LinkButton without javascript'
author: timvw
post_date: 2008-10-14 17:06:08
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/10/14/adaptive-control-behavior-linkbutton-without-javascript/
published: true
---
<p>'Experiment with <a href="http://msdn.microsoft.com/en-us/library/67276kc5.aspx">Adaptive Control Behavior</a>' has been an item on my TO-DO list for a very long time and this weekend i finally found some time to do exactly that. Because i hate it that a <a href="http://msdn.microsoft.com/en-us/library/system.web.ui.webcontrols.linkbutton.aspx">LinkButton</a> renders as &lt;a href="javascript:__doPostBackxxx"&gt; i decided to develop a <a href="http://msdn.microsoft.com/en-us/library/system.web.ui.adapters.controladapter.aspx">ControlAdapter</a> that makes the LinkButton work without JavaScript. While i was at it i also wrote adapters for the <a href="http://msdn.microsoft.com/en-us/library/system.web.ui.webcontrols.loginstatus(VS.80).aspx">LoginStatus</a> and <a href="http://msdn.microsoft.com/en-us/library/system.web.ui.webcontrols.login.aspx">Login</a> controls. Feel free to play with the <a href="http://www.timvw.be/wp-content/code/csharp/AdaptiveRenderingDemo.zip">Adaptive Rendering Demo</a>.