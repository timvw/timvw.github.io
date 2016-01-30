---
ID: 2330
post_title: >
  The curious case of trailing spaces in
  SQL
author: timvw
post_date: 2013-04-27 17:38:29
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2013/04/27/the-curious-case-of-trailing-spaces-in-sql/
published: true
dsq_thread_id:
  - "1920088178"
dsq_needs_sync:
  - "1"
---
<p>A while ago I was quite surprised to see that the following query returns 1 instead of 0:</p>

[code lang="sql"]
SELECT COUNT(*) WHERE N'Tim' = N'Tim '; -- notice the trailing space
[/code]

<p>Apparently this is just standard behaviour. Here is an extract from <a href="http://www.andrew.cmu.edu/user/shadow/sql/sql1992.txt">sql1992.txt</a> (Section 8.2 Paragraph 3):</p>

<quote><pre>
     3) The comparison of two character strings is determined as fol-
            lows:

            a) If the length in characters of X is not equal to the length
              in characters of Y, then the shorter string is effectively
              replaced, for the purposes of comparison, with a copy of
              itself that has been extended to the length of the longer
              string by concatenation on the right of one or more pad char-
              acters, where the pad character is chosen based on CS. If
              CS has the NO PAD attribute, then the pad character is an
              implementation-dependent character different from any char-
              acter in the character set of X and Y that collates less
              than any string under CS. Otherwise, the pad character is a
              <space>.

            b) The result of the comparison of X and Y is given by the col-
              lating sequence CS.

            c) Depending on the collating sequence, two strings may com-
              pare as equal even if they are of different lengths or con-
              tain different sequences of characters. When the operations
              MAX, MIN, DISTINCT, references to a grouping column, and the
              UNION, EXCEPT, and INTERSECT operators refer to character
              strings, the specific value selected by these operations from
              a set of such equal values is implementation-dependent.
</pre></quote>