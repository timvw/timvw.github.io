---
id: 2425
title: Cute sort implementation
date: 2014-07-28T09:08:31+00:00
author: timvw
layout: post
guid: http://www.timvw.be/?p=2425
permalink: /2014/07/28/cute-sort-implementation/
categories:
  - Uncategorized
tags:
  - C
---
For years I had been implementing my [sort functions](http://msdn.microsoft.com/en-us/library/tfakywbh(v=vs.110).aspx) as following:

```csharp
(x,y) => {  
	if (x.PartName == null && y.PartName == null) return 0;
	if (x.PartName == null) return -1;
	if (y.PartName == null) return 1; 
	return x.PartName.CompareTo(y.PartName);
}
```

Earlier today I found the following cute variant while browsing through the [ServiceStack](https://github.com/ServiceStack/ServiceStack/blob/v3/src/ServiceStack/WebHost.Endpoints/Utils/FilterAttributeCache.cs) codebase:

```csharp
(x,y) => x.Priority - y.Priority  
```