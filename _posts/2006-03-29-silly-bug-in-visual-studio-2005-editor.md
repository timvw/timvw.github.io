---
title: Silly bug in Visual Studio 2005 editor
layout: post
tags:
  - Visual Studio
---
If you try to compile the code below you will see that the i in the second loop is not defined in my main function. Position your mouse over the i, click right and choose "Go To Definition" in the context menu. Why does the cursor move to the i in the struct? Btw, if you remove the first for loop this doesn't happen.

```cpp
#include "stdafx.h"
struct {
int i;
} BLAH;

int _tmain(int argc, _TCHAR* argv[]) {
	for (int i = 0; i < 10; ++i) { ; } 
	for (i = 0; i < 10; ++i) { ; } 
	return 0; 
} 
```
