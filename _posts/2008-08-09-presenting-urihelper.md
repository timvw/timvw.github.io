---
ID: 371
post_title: Presenting UriHelper
author: timvw
post_date: 2008-08-09 13:38:28
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/08/09/presenting-urihelper/
published: true
---
<p>Adding parameters to an <a href="http://msdn.microsoft.com/en-us/library/system.uri.aspx">Uri</a> is an example where my <a href="http://www.timvw.be/presenting-namevaluecollectionhelper/">NameValueCollectionHelper</a> comes in handy. Although <a href="http://msdn.microsoft.com/en-us/library/system.uritemplate.aspx">UriTemplate</a> allows us to bind parameters, it doesn't really support add/remove/fail on duplicate parameters. Here is an example:</p>

[code lang="csharp"][TestMethod]
public void TestAddParametersReplaceWithReplaceOfExistingParameters()
{
 Uri originalUri = new Uri("http://www.example.com/path/?key1=val1&key2=val2#abcd")

 NameValueCollection parameters = new NameValueCollection();
 parameters.Add("key1", "newval");
 parameters.Add("key3", "val3");

 Uri expected = new Uri("http://www.example.com/path/?key1=newval&key2=val2&key3=val3#abcd");

 Uri actual = UriHelper.AddParameters(originalUri, parameters, DuplicateKeyBehavior.Replace);
 Assert.AreEqual(expected, actual);
}[/code]

<p>Once again, source of this class can be found at <a href="http://www.codeplex.com/BeTimvwFramework">BeTimvwFramework</a>.</p>