---
ID: 110
post_title: GNU text utilities
author: timvw
post_date: 2005-11-03 02:13:33
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/11/03/gnu-text-utilities-2/
published: true
---
<p>I've already written that i like the <a href="http://www.gnu.org/software/textutils/textutils.html">GNU Textutils</a> a lot. Today someone had the following problem: A textfile with words. It's possible that a word is repeated a couple of times. He wants to generate a newfile without duplicate words. The solution is pretty simple:</p>
[code lang="bash"]
sort words.txt | uniq > newfile.txt
[/code]