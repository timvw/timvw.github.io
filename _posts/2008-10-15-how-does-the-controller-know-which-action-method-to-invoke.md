---
ID: 696
post_title: >
  How does the controller know which
  action method to invoke?
author: timvw
post_date: 2008-10-15 07:46:08
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/10/15/how-does-the-controller-know-which-action-method-to-invoke/
published: true
---
<p>Yesterday i attended another great <a href="http://www.visug.be">VISUG</a> event on ASP.NET presented by <a href="http://blog.maartenballiauw.be/">Maarten Balliauw</a>. He demonstrated a custom filter but did not dig into the mechanics of action method resolving. With the aid of of the ActionName attribute we can map different methods to the same action. The following methods will all map to the same "Detail" action:</p>

[code lang="csharp"]public ActionResult Detail(int productId) { ... }
public ActionResult Detail(int productId, string name) { ... }
[ActionName("Detail")] public ActionResult DisplayDetail(int productId) { ... }
[ActionName("Detail")] public ActionResult ModifyDetail(int productId, string name) { ... }[/code]

<p>So how does the Controller know which method to invoke? The answer can be found in the ActionMethodSelector which tries to find the method as following:</p>

[code lang="csharp"]public MethodInfo FindActionMethod(ControllerContext controllerContext, string action)
{
 List<methodInfo> methodsMatchingName = GetMatchingAliasedMethods(controllerContext, action);
 methodsMatchingName.AddRange(NonAliasedMethods[action]);
 List<methodInfo> finalMethods = RunSelectionFilters(controllerContext, methodsMatchingName);

 switch (finalMethods.Count)
 {
  case 0: return null;
  case 1: return finalMethods[0];
  default: throw CreateAmbiguousMatchException(finalMethods, action);
 }
}[/code]

<p>In the RunSelectionFilters method all the found ActionSelection Attributes have their IsValidForRequest method called in the hope that only one potential method remains.</p>

<p>The most common scenario is that we want our controller to behave depending upon the request method (POST vs GET). For this scenario there is the AcceptVerbsAttribute. eg:</p>

[code lang="csharp"][ActionName("Detail")]
[AcceptVerbs("GET")]
public ActionResult DisplayDetail(int productId) { ... }

[ActionName("Detail")]
[AcceptVerbs("POST")]
public ActionResult ModifyDetail(int productId, string name) { ... }[/code]

<p>The implementation of the IsValidForRequest method in the AcceptVerbsAttribute is pretty simple:</p>

[code lang="csharp"]public override bool IsValidForRequest(ControllerContext controllerContext, MethodInfo methodInfo)
{
 if (controllerContext == null) throw new ArgumentNullException("controllerContext");

 string incomingVerb = controllerContext.HttpContext.Request.HttpMethod;
 return Verbs.Contains(incomingVerb, StringComparer.OrdinalIgnoreCase);
}[/code]