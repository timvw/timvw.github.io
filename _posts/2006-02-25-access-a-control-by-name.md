---
title: Access a control by name
layout: post
tags:
  - Visual Basic
---
I know a mathematician that can do magic with stats. That's also the reason why he works at [Eurostat](http://epp.eurostat.cec.eu.int/portal/page?_pageid=1090,30070682,1090_33076576&_dad=portal&_schema=PORTAL). He's automating a lot of his work by programming in [Visual Basic for Applications](http://msdn.microsoft.com/isv/technology/vba/default.aspx). He asked me if i wanted to look at his code because he had the feeling there was a smell. Here are a couple lines

```vb
With SomeForm
.txtJanvier60.Value = vaData1(1, 2)
.txtFevrier60.Value = vaData1(1, 3)
.txtJanvier61.Value = vaData1(1, 2)
.txtFevrier61.Value = vaData1(1, 3)
...
.txtJanvier70.Value = vaData1(1, 2)
.txtFevrier70.Value = vaData1(1, 3)
End With
```

It took me 5 minutes to search the web and change his code as following:

```vb
Dim months(1) as String
months(0) = "Janvier"
months(1) = "Fevrier"

With SomeForm
For i = 60 to 70
For j = 0 to UBound(months)
.Controls("txt" & months(j) & CStr(i)).Value = vaData1(1, j + 2)
Next j
Next i
End With
```
