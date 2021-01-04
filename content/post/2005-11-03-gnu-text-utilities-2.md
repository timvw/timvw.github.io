---
date: "2005-11-03T00:00:00Z"
tags:
- Free Software
title: GNU text utilities
aliases:
 - /2005/11/03/gnu-text-utilities-2/
 - /2005/11/03/gnu-text-utilities-2.html
---
I've already written that i like the [GNU Textutils](http://www.gnu.org/software/textutils/textutils.html) a lot. Today someone had the following problem: A textfile with words. It's possible that a word is repeated a couple of times. He wants to generate a newfile without duplicate words. The solution is pretty simple

```bash
sort words.txt | uniq > newfile.txt
```
