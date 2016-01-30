---
ID: 584
post_title: Refactoring ApplicationEnvironment
author: timvw
post_date: 2008-09-23 16:39:03
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/09/23/refactoring-applicationenvironment/
published: true
---
<p>Yesterday i blogged about an <a href="http://www.timvw.be/presenting-applicationenvironment/">ApplicationEnvironment</a> which had a dependency on the application configuration file. With my <a href="http://www.timvw.be/presenting-configurationfilesession/">ConfigurationFileSession</a> i was able to test the implementation despite that dependency. Today i modified the design a little so that i do not require the ConfigurationFileSession hack anymore.</p>

<p>First i added an internal constructor as following:</p>

[code lang="csharp"]internal protected ApplicationEnvironment(DateTime instanceEpoch, DateTime applicationEpoch)
{
 this.instanceEpoch = instanceEpoch;
 this.applicationEpoch = applicationEpoch;
}[/code]

<p>Then i made the internals visible to the test project:</p>
[code lang="csharp"]
[assembly: InternalsVisibleTo("Be.Timvw.Framework.Domain.Tests")]
[/code]

<p>And finally i added a base class that takes care of the initialization and clean up as following:</p>
[code lang="csharp"][TestInitialize]
public void TestInitialize()
{
 this.original = ApplicationEnvironment.Instance;
 ApplicationEnvironment.Instance = new ApplicationEnvironment(DateTime.UtcNow, new DateTime(1998, 01, 01));
}

[TestCleanup]
public void TestCleanUp()
{
 ApplicationEnvironment.Instance = this.original;
}[/code]