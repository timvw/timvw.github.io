---
date: "2010-02-17T00:00:00Z"
guid: http://www.timvw.be/?p=1697
tags:
- CSharp
title: 'Learned something from Resharper: Enumerable.OfType<TResult>'
aliases:
 - /2010/02/17/learned-something-from-resharper-enumerable-oftypetresult/
 - /2010/02/17/learned-something-from-resharper-enumerable-oftypetresult.html
---
A couple of weeks ago i discovered [Enumerable.OfType<TResult>](http://msdn.microsoft.com/en-us/library/bb360913.aspx) when i let Resharper rewrite my code as a Linq statement. Here is the original code:

```csharp
var selectedPersons = new List<personSelectItem>();
foreach(var selectedItem in selectedItems)
{
	var selectedPerson = selectedItem as PersonSelectItem;
	if (selectedPerson == null) continue;
	selectedPersons.Add(selectedPerson);
}
```

And here is how it looks after the rewrite:

```csharp
var selectedPersons = selectedItems.OfType<personSelectItem>().ToList();
```

Yup, the [Resharper](http://www.jetbrains.com/resharper/) license was definitely worth it's money.
