---
ID: 718
post_title: >
  Refactoring Application Environment
  (Part 2)
author: timvw
post_date: 2008-10-17 17:02:58
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/10/17/refactoring-application-environment-part-2/
published: true
---
<p><a href="http://lucamilan.blogspot.com/">Luca Milan</a> notified me of a design issue. Until now the ApplicationEnvironment had an Instance property as following:</p>

[code lang="csharp"]public static ApplicationEnvironment Instance { get { ... } }[/code]

<p>A lot of flexibility can be added by extracting an interface IApplicationEnvironment and use that as return type for the property:</p>

[code lang="csharp"]public static IApplicationEnvironment Instance { get { ... } }[/code]

<p>Now that we have <a href="http://www.codeplex.com/CommonServiceLocator">Common Service Locator</a> i have decided to completely remove the Instance property. Code that requires an instance of the IApplicationEnvironment will have to resolve it via the ServiceLocator:</p>

[code lang="csharp"]IApplicationEnvironment appEnv = ServiceLocator.Current.GetInstance<iapplicationEnvironment>();[/code]