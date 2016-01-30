---
ID: 101
post_title: GNU text utilities
author: timvw
post_date: 2005-07-06 01:55:45
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2005/07/06/gnu-text-utilities/
published: true
---
<p>More and more i seem to recieve requests from people that need to manipulate some text files.
And they don't feel like doing it manually. So here are some examples of how i used the
<a href="http://www.gnu.org/software/textutils/manual/textutils/textutils.html">GNU text utilities</a>: </p>

<p>I want to split the file below into one with the questions and one with the answers. This can be easily done: </p>

<pre>
Who is the manual.*I am
Who am i.*The manual
What was HLN's first #1 hit.*Power of love
Which News man is the oldest.*Huey
About how many months did it take to record Small World.*4
Who wrote Jacob's Ladder.*Bruce Hornsby
</pre>

[code lang="bash"]
cut -d "." -f1 trivia.txt > questions.txt
cut -d "*" -f2 trivia.txt > answers.txt
[/code]

<p>I want to know how many times people have logged in. With last i recieve output like below.
I generate a top10 list:  </p>

<pre>
xabre    pts/0        cable-213-132-14 Wed Jul  6 14:41   still logged in
veurm    pts/16       80.236.195.247   Wed Jul  6 14:28   still logged in
timvw    pts/6        ip-213-49-86-220 Wed Jul  6 14:21   still logged in
ward     pts/1        dd5768f62.access Wed Jul  6 14:04   still logged in
bokkerij pts/1        91.42-201-80.ads Wed Jul  6 13:57 - 14:00  (00:02)
cowke    pts/54       215-157.241.81.a Wed Jul  6 13:37    gone - no logout
mette    pts/51       ip-213-49-112-10 Wed Jul  6 13:36   still logged in
esumlu   pts/49       176.228-201-80.a Wed Jul  6 13:25   still logged in
veurm    pts/6        ip-213-49-84-129 Wed Jul  6 13:21 - 14:10  (00:49)
trooperz pts/6        160.148-136-217. Wed Jul  6 13:05 - 13:21  (00:15)
gunther  pts/40       d5153d0d9.access Wed Jul  6 12:28   still logged in
timvw    pts/34       ip-213-49-86-220 Wed Jul  6 11:02 - 14:21  (03:19)
</pre>

[code lang="bash"]
last | cut -d " " -f1 | sort | uniq -c | sort -rn | head
[/code]

<p>I want to use this file to generate two files, one for small galleries (&lt;10 photos) and one for large
galleries (&gt;= 10 photos)</p>

<pre>
http://example.com/gallery1|Fishing|18
http://example.com/gallery2|Fishing|5
http://example.com/gallery3|Fishing|6
http://example.com/gallery4|Fishing|5
http://example.com/gallery5|Fishing|35
http://example.com/gallery6|Fishing|2
http://example.com/gallery7|Fishing|1
http://example.com/gallery8|Fishing|9
</pre>

[code lang="bash"]
grep  -E "(.*?)\|[0-9]{1}$" galleries.txt > small.txt
grep -vE "(.*?)\|[0-9]{1}$" galleries.txt >large.txt
[/code]