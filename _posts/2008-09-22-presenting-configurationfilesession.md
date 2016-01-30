---
ID: 565
post_title: Presenting ConfigurationFileSession
author: timvw
post_date: 2008-09-22 17:08:46
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/09/22/presenting-configurationfilesession/
published: true
---
<p>Here is a little class that allows you to use different configuration files. I find it extremely useful for tests where i want to mock the values that would be retrieved via the <a href="http://msdn.microsoft.com/en-us/library/system.configuration.configurationmanager.aspx">ConfigurationManager</a>. Here are a couple of examples how it can be used:</p>

[code lang="csharp"][TestMethod]
public void ShouldUseSystemTimeWhenNoValuesAreProvided()
{
 using (new ConfigurationFileSession("WithoutDateTimeManipulation.config"))
 {
  ApplicationEnvironment.Instance.Refresh();

  DateTime now = DateTime.UtcNow;
  TimeSpan allowedDifference = TimeSpan.FromSeconds(1);
  TimeSpan actualDifference = ApplicationEnvironment.Instance.CurrentDateTime - configurationNow;
  Assert.IsTrue(actualDifference  < allowedDifference);
 }
}

[TestMethod]
public void ShouldUseValuesAsProvided()
{
 using (new ConfigurationFileSession("WithDateTimeManipulation.config"))
 {
  ApplicationEnvironment.Instance.Refresh();

  DateTime now = new DateTime(2000, 1, 1);
  TimeSpan allowedDifference = TimeSpan.FromSeconds(1);
  TimeSpan actualDifference = ApplicationEnvironment.Instance.CurrentDateTime - configurationNow;
  Assert.IsTrue(actualDifference < allowedDifference);
 }
}[/code]

<p>Feel free to download the code from <a href="http://www.codeplex.com/BeTimvwFramework">BeTimvwFramework</a>.