---
ID: 69
post_title: Multiple joins explained
author: timvw
post_date: 2006-02-03 21:52:06
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/02/03/multiple-joins-explained/
published: true
---
<p>I'll try to explain how a join on more than one table works. I've noticed people get confused by it. Assume we have the following tables:</p>

<ul>
<li>newsitems(news_id,post_id)</li>
<li>postitems(post_id,user_id,content)</li>
<li>users(user_id,name,password)</li>
</ul>

<p>
We want to display for each newsitem the content and the author.
</p>

<p>
Our base table would be the newsitems, and then we join using the item_id. Thus the query would be: </p>
[code lang="sql"]
SELECT *
FROM newsitems
INNER JOIN ON postitems USING (post_id)
[/code]

<p>
This returns a "virtual table" that has looks like this result(news_id,post_id,user_id,content).
</p>

<p>
Now we still need to get the username, so we use our result table and perform a join on the users table. Thus the query would be:</p>
[code lang="sql"]
SELECT *
FROM result
INNER JOIN users USING (user_id)
[/code]

<p>
If we combine our first two queries, we end up with this:</p>
[code lang="sql"]
SELECT *
FROM newsitems
INNER JOIN postitems USING (post_id)
INNER JOIN users USING (user_id)
[/code]

<p>Conclusion: Look at A*B*C as (A*B)*C to easily understand multiple joins</p>