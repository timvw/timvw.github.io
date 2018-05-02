---
id: 110
title: GNU text utilities
date: 2005-11-03T02:13:33+00:00
author: timvw
layout: post
guid: http://www.timvw.be/gnu-text-utilities-2/
permalink: /2005/11/03/gnu-text-utilities-2/
tags:
  - Free Software
---
I've already written that i like the [GNU Textutils](http://www.gnu.org/software/textutils/textutils.html) a lot. Today someone had the following problem: A textfile with words. It's possible that a word is repeated a couple of times. He wants to generate a newfile without duplicate words. The solution is pretty simple

```bash
sort words.txt | uniq > newfile.txt
```
