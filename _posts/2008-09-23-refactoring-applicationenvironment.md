---
id: 584
title: Refactoring ApplicationEnvironment
date: 2008-09-23T16:39:03+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=584
permalink: /2008/09/23/refactoring-applicationenvironment/
tags:
  - 'C#'
---
Yesterday i blogged about an [ApplicationEnvironment](http://www.timvw.be/presenting-applicationenvironment/) which had a dependency on the application configuration file. With my [ConfigurationFileSession](http://www.timvw.be/presenting-configurationfilesession/) i was able to test the implementation despite that dependency. Today i modified the design a little so that i do not require the ConfigurationFileSession hack anymore.

First i added an internal constructor as following

```csharp
internal protected ApplicationEnvironment(DateTime instanceEpoch, DateTime applicationEpoch)
{
	this.instanceEpoch = instanceEpoch;
	this.applicationEpoch = applicationEpoch;
}
```

Then i made the internals visible to the test project

```csharp
[assembly: InternalsVisibleTo("Be.Timvw.Framework.Domain.Tests")]
```

And finally i added a base class that takes care of the initialization and clean up as following

```csharp
[TestInitialize]
public void TestInitialize()
{
	this.original = ApplicationEnvironment.Instance;
	ApplicationEnvironment.Instance = new ApplicationEnvironment(DateTime.UtcNow, new DateTime(1998, 01, 01));
}

[TestCleanup]
public void TestCleanUp()
{
	ApplicationEnvironment.Instance = this.original;
}
```
