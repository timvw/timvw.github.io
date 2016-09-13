---
ID: 571
post_title: Presenting ApplicationEnvironment
author: timvw
post_date: 2008-09-22 17:18:11
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/09/22/presenting-applicationenvironment/
published: true
dsq_thread_id:
  - "1933325137"
---
<p>Imagine we are an ice cream vendor. During summer months our available capacity is twice as high as in the rest of the year. In code this problem looks like the following:</p>

[code lang="csharp"]public int AvailableCapacity
{
 get
 {
  DateTime now = DateTime.UtcNow;

  if (new DateTime(now.Year, 6, 1) <= now && now <= new DateTime(now.Year, 9, 1)  )
  {
   return 10000;
  }
  else
  {
   return 5000;
  }
 }
}[/code]

<p>This code is pretty difficult to test because it depends on DateTime.UtcNow. In order to get control over that dependency i have defined an ApplicationEnvironment and rewritten the code as following:</p>

[code lang="csharp"]public int AvailableCapacity
{
 get
 {
  DateTime now = ApplicationEnvironment.Instance.CurrentDateTime;

  if (new DateTime(now.Year, 6, 1) <= now && now <= new DateTime(now.Year, 9, 1)  )
  {
   return 10000;
  }
  else
  {
   return 5000;
  }
 }
}[/code]

<p>Now i can use my <a href="http://www.timvw.be/presenting-configurationfilesession/">ConfigurationFileSession</a> to test this code:</p>

[code lang="csharp"][TestMethod]
public void ShouldReturn10000InSummer()
{
 using (new ConfigurationFileSession("Summer.config"))
 {
  ApplicationEnvironment.Instance.Refresh();
  Assert.AreEqual(10000, new IceCreamPlant().AvailableCapacity);
 }
}

[TestMethod]
public void ShouldReturn5000InWinter()
{
 using (new ConfigurationFileSession("Winter.config"))
 {
  ApplicationEnvironment.Instance.Refresh();
  Assert.AreEqual(5000, new IceCreamPlant().AvailableCapacity);
 }
}[/code]