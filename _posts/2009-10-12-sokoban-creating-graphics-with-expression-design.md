---
title: 'Sokoban: Creating graphics with Expression Design'
layout: post
guid: http://www.timvw.be/?p=1393
dsq_thread_id:
  - 1933324543
tags:
  - Silverlight
  - WPF
---
Earlier this morning i decided to improve the graphics the little. I launched Expression Design, created a new image, and drew each possible cell and piece in a seperate layer. With this technique i can easily preview how a "Box" on "Goal" looks like.

For each layer i simply copied the XAML from Expression Design into my Cell.xaml file. Apparently all the layers are interpreted as a Canvas and the layer name determines their x:Name which makes it pretty easy to make the correct canvasses visible. With a simple ScaleTransform i can ensure that the canvasses are sized correctly.

Here is the updated version of Sokoban:

<div id="silverlightControlHost2">
  <br />
</div>
