---
ID: 1368
post_title: Presenting Sokoban with Silverlight
author: timvw
post_date: 2009-10-10 11:35:33
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/10/10/presenting-sokoban-with-silverlight/
published: true
---
<p>Despite the blablah postings, i have been able to code a little, so here is the boomboom: Sokoban.</p>

<div id="silverlightControlHost">
 <object data="data:application/x-silverlight-2," type="application/x-silverlight-2"  width="850" height="400">
  <param name="source" value="http://www.timvw.be/ClientBin/Sokoban.xap"/>
  <param name="onError" value="onSilverlightError" />
  <param name="background" value="white" />
  <param name="minRuntimeVersion" value="3.0.40624.0" />
  <param name="autoUpgrade" value="true" />
  <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=3.0.40624.0" style="text-decoration:none">
   <img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style:none"/>
  </a>
 </object>
 <iframe id="_sl_historyFrame" style="visibility:hidden;height:0px;width:0px;border:0px"></iframe>
</div>