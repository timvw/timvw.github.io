---
ID: 1697
post_title: 'Learned something from Resharper: Enumerable.OfType&lt;TResult&gt;'
author: timvw
post_date: 2010-02-17 19:18:23
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2010/02/17/learned-something-from-resharper-enumerable-oftypetresult/
published: true
---
<p>A couple of weeks ago i discovered <a href="http://msdn.microsoft.com/en-us/library/bb360913.aspx">Enumerable.OfType&lt;TResult&gt;</a> when i let Resharper rewrite my code as a Linq statement. Here is the original code:</p>

[code lang="csharp"]var selectedPersons = new List<personSelectItem>();
foreach(var selectedItem in selectedItems)
{
 var selectedPerson = selectedItem as PersonSelectItem;
 if (selectedPerson == null) continue;
 selectedPersons.Add(selectedPerson);
}[/code]

<p>And here is how it looks after the rewrite:</p>

[code lang="csharp"]var selectedPersons = selectedItems.OfType<personSelectItem>().ToList();[/code]

<p>Yup, the <a href="http://www.jetbrains.com/resharper/">Resharper</a> license was definitely worth it's money.</p>