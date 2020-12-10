---
title: Presenting UriHelper
layout: post
guid: http://www.timvw.be/?p=371
tags:
  - 'C#'
---
Adding parameters to an [Uri](http://msdn.microsoft.com/en-us/library/system.uri.aspx) is an example where my [NameValueCollectionHelper](http://www.timvw.be/presenting-namevaluecollectionhelper/) comes in handy. Although [UriTemplate](http://msdn.microsoft.com/en-us/library/system.uritemplate.aspx) allows us to bind parameters, it doesn't really support add/remove/fail on duplicate parameters. Here is an example

```csharp
[TestMethod]
public void TestAddParametersReplaceWithReplaceOfExistingParameters()
{
	Uri originalUri = new Uri("http://www.example.com/path/?key1=val1&key2=val2#abcd")

	NameValueCollection parameters = new NameValueCollection();
	parameters.Add("key1", "newval");
	parameters.Add("key3", "val3");

	Uri expected = new Uri("http://www.example.com/path/?key1=newval&key2=val2&key3=val3#abcd");

	Uri actual = UriHelper.AddParameters(originalUri, parameters, DuplicateKeyBehavior.Replace);
	Assert.AreEqual(expected, actual);
}
```

Once again, source of this class can be found at [BeTimvwFramework](http://www.codeplex.com/BeTimvwFramework).
