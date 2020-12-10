---
title: Exploring graphical programming with Blend, Visual State Manager and Behaviors
layout: post
guid: http://www.timvw.be/?p=1437
tags:
  - Silverlight
  - WPF
---
A while ago i presented the [ControlStateMachine](http://www.timvw.be/experimenting-with-controlstatemachine-and-fluent-interfaces/) and in Silverlight this concept is implemented as the [Visual State Manager](http://windowsclient.net/wpf/wpf35/wpf-35sp1-toolkit-visual-state-manager-overview.aspx).

In my sokoban implementation i have a cellview which exists out of 6 canvasses but only two of them (one for the cell type and one for the piece type) are visible at any given point in time. I have implemented this with 6 properties CanvasXVisible (with X being Player, Box, Wall, Goal, Floor and Cell) in my ViewModel but a State Machine / Manager may help clarify how the visibility of the canvasses are related. Here are the 2 visual state groups and their states that i would need for the CellView

![screenshot of visual state manager in expression blend](http://www.timvw.be/wp-content/images/cellview-vsm.png)

As you can see there is quite a lof of XAML involved to make the correct canvas visible:

```xml
<visualState x:Name="Space1">
 <storyboard>
  <objectAnimationUsingKeyFrames BeginTime="00:00:00"  Duration="00:00:00.0010000"
   Storyboard.TargetName="Space"  Storyboard.TargetProperty="(UIElement.Visibility)">
    <discreteObjectKeyFrame KeyTime="00:00:00">
     <discreteObjectKeyFrame.Value>
      <visibility>Visible</visibility>
     </discreteObjectKeyFrame.Value>
    </discreteObjectKeyFrame>
   </objectAnimationUsingKeyFrames>
  </storyboard>
</visualState>
```

For a simple modification to the Visibility property this seems like overkill but in many situations you will want to change more than this one property.

With the aid of the behaviors that come with Blend i can quickly add a couple of radio buttons, toss in some gotostate actions and end up with an interactive application:

<img src="http://www.timvw.be/wp-content/images/gotostateaction.png" alt="screenshot of gotostate action properties" />

```xml
<radioButton Width="63" Canvas.Left="8" Canvas.Top="172" Content="Wall" GroupName="PieceTypes">
 <i:Interaction.Triggers>
  <i:EventTrigger EventName="Checked">
   <ic:GoToStateAction StateName="Wall1"/>
  </i:EventTrigger>
 </i:Interaction.Triggers>
</radioButton>
```

Feel free to try it yourself by changing the radio buttons

```xml
<div id="exploringVSM">
 <object data="data:application/x-silverlight-2," type="application/x-silverlight-2"  width="300" height="240">
  <param name="source" value="http://www.timvw.be/ClientBin/ExploringVSM.xap"/>
  <param name="onError" value="onSilverlightError" />
  <param name="background" value="white" />
  <param name="minRuntimeVersion" value="3.0.40624.0" />
  <param name="autoUpgrade" value="true" />
  <a href="http://go.microsoft.com/fwlink/?LinkID=149156&#038;v=3.0.40624.0" style="text-decoration:none">
   <img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style:none"/>
  </a>
 </object>
 <iframe id="_sl_historyFrame" style="visibility:hidden;height:0px;width:0px;border:0px"></iframe>
</div></div>
```

Conclusion: All in all it is relatively easy to create interactive applications using Blend without writing a single line of code. 
Too bad that the behaviors are in an Expression assembly and don't come with standard Silverlight. 
Another attention point is the maintainability of this new style of programming.
