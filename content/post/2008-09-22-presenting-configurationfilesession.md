---
date: "2008-09-22T00:00:00Z"
guid: http://www.timvw.be/?p=565
tags:
- CSharp
title: Presenting ConfigurationFileSession
aliases:
 - /2008/09/22/presenting-configurationfilesession/
 - /2008/09/22/presenting-configurationfilesession.html
---
Here is a little class that allows you to use different configuration files. I find it extremely useful for tests where i want to mock the values that would be retrieved via the [ConfigurationManager](http://msdn.microsoft.com/en-us/library/system.configuration.configurationmanager.aspx). Here are a couple of examples how it can be used

```csharp
[TestMethod]
public void ShouldUseSystemTimeWhenNoValuesAreProvided()
{
	using (new ConfigurationFileSession("WithoutDateTimeManipulation.config"))
	{
		ApplicationEnvironment.Instance.Refresh();

		DateTime now = DateTime.UtcNow;
		TimeSpan allowedDifference = TimeSpan.FromSeconds(1);
		TimeSpan actualDifference = ApplicationEnvironment.Instance.CurrentDateTime -- configurationNow;
		Assert.IsTrue(actualDifference < allowedDifference); 
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
}
``` 

Feel free to download the code from [BeTimvwFramework](http://www.codeplex.com/BeTimvwFramework).
