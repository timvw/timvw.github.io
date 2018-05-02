---
id: 57
title: Preparing for my internship
date: 2006-02-11T21:26:22+00:00
author: timvw
layout: post
guid: http://www.timvw.be/preparing-for-my-internship/
permalink: /2006/02/11/preparing-for-my-internship/
tags:
  - C++
---
Only two more days before my internship starts. I'm a bit nervous and excited to dive into this adventure. Today i decided to fresh my knowledge of (MS)-C++ a bit up. I've read a tutorial on [function pointers](http://www.newty.de/fpt/index.html) and [naming conventions](http://msdn.microsoft.com/library/default.asp?url=/library/en-us/vccore98/html/_core_argument_passing_and_naming_conventions.asp). A couple of weeks ago i already had a look at [pointers to member functions](http://linuxquality.sunsite.dk/articles/memberpointers/).

```cpp
#include <iostream>
using namespace std;

void customcallback() {
	cout << "running custom callback" << endl; 
} 
typedef int (\*method)(int, int); 
int sum(int a, int b) { return a + b; } 
method dosum() { return &sum; } 

int main() { 
	void (\*plugin)() = NULL; 
	plugin = &customcallback; 
	plugin(); 
	method mymethod = dosum(); 
	cout << mymethod(10, 4) << endl; 
	return 0; 
} 
```
