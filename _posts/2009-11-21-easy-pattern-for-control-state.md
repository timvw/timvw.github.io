---
ID: 1531
post_title: Easy pattern for Control state
author: timvw
post_date: 2009-11-21 18:32:03
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2009/11/21/easy-pattern-for-control-state/
published: true
---
<p>If you have decided that your WebControl requires to maintain it's state you will want to figure out how to implement Control state. Most examples on the web will then create an array of objects and then hardcode the indices to find stuff back... Simply define a serializable inner class and use that instead of the 'magic array object'. Eg:</p>

[code lang="csharp"]class SilverlightHost : WebControl
{
 [Serializable]
 class State
 {
  public object BaseState { get; set; }
  public string SilverlightUrl { get; set; }
  public string SilverlightErrorHandlerUrl { get; set; }
  public Dictionary<string, string> Parameters { get; set; }
 }

 protected override void OnInit(EventArgs e)
 {
  base.OnInit(e);
  Page.RegisterRequiresControlState(this);
 }

 protected override object SaveControlState()
 {
  var state = new State
  {
   BaseState = base.SaveControlState(),
   SilverlightUrl = SilverlightUrl,
   SilverlightErrorHandlerUrl = SilverlightErrorHandlerUrl,
   Parameters = parameters
  };
  return state;
 }

 protected override void LoadControlState(object savedState)
 {
  var state = (State)savedState;
  SilverlightUrl = state.SilverlightUrl;
  SilverlightErrorHandlerUrl = state.SilverlightErrorHandlerUrl;
  parameters = state.Parameters;
  base.LoadControlState(state.BaseState);
 }
}[/code]