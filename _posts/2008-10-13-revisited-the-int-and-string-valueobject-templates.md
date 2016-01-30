---
ID: 677
post_title: >
  Revisited the int and string ValueObject
  templates
author: timvw
post_date: 2008-10-13 18:08:45
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2008/10/13/revisited-the-int-and-string-valueobject-templates/
published: true
---
<p>After reading <a href="http://blogs.msdn.com/bclteam/archive/2008/10/06/the-compare-contract-kim-hamilton.aspx">The Compare Contract</a> last week i realized that my <a href="http://www.timvw.be/presenting-templates-for-int-and-string-valueobjects">templates for int and string ValueObjects</a> did not comply with the contract so i decided to add a unittest that reproduces the faulty behavior (and then corrected the implementation):</p>

[code lang="csharp"]/// <summary>
/// When comparing instance with null, instance should be greater.
/// </summary>
[TestMethod]
public void ShouldReturnPositiveWhenComparedWithNull()
{
 $classname$ value = new $classname$("0");
 Assert.IsTrue(value.CompareTo(null) > 0);
}[/code]

<p>Anyway, feel free to download the corrected <a href="http://www.timvw.be/wp-content/code/csharp/IntValueObject.zip">IntValueObject</a> and <a href="http://www.timvw.be/wp-content/code/csharp/StringValueObject.zip">StringValueObject</a> templates.</p>