---
ID: 1393
post_title: 'Sokoban: Creating graphics with Expression Design'
author: timvw
post_date: 2009-10-12 09:32:37
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/10/12/sokoban-creating-graphics-with-expression-design/
published: true
dsq_thread_id:
  - "1933324543"
---
<p>Earlier this morning i decided to improve the graphics the little. I launched Expression Design, created a new image, and drew each possible cell and piece in a seperate layer. With this technique i can easily preview how a "Box" on "Goal" looks like.</p>

<p>For each layer i simply copied the XAML from Expression Design into my Cell.xaml file. Apparently all the layers are interpreted as a Canvas and the layer name determines their x:Name which makes it pretty easy to make the correct canvasses visible. With a simple ScaleTransform i can ensure that the canvasses are sized correctly.</p>

<p>Here is the updated version of Sokoban:</p>

<div id="silverlightControlHost2">
 <object data="data:application/x-silverlight-2," type="application/x-silverlight-2"  width="850" height="400">
  <param name="source" value="http://www.timvw.be/ClientBin/Sokoban2.xap"/>
  <param name="onError" value="onSilverlightError" />
  <param name="background" value="white" />
  <param name="minRuntimeVersion" value="3.0.40624.0" />
  <param name="autoUpgrade" value="true" />
  <a href="http://go.microsoft.com/fwlink/?LinkID=149156&#038;v=3.0.40624.0" style="text-decoration:none">
   <img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style:none"/>
  </a>
 </object>
 <iframe id="_sl_historyFrame" style="visibility:hidden;height:0px;width:0px;border:0px"></iframe>
</div>