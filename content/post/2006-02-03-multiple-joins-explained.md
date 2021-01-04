---
date: "2006-02-03T00:00:00Z"
tags:
- SQL
title: Multiple joins explained
aliases:
 - /2006/02/03/multiple-joins-explained/
 - /2006/02/03/multiple-joins-explained.html
---
I'll try to explain how a join on more than one table works. I've noticed people get confused by it. Assume we have the following tables

* newsitems(news_id,post_id)
* postitems(post_id,user_id,content)
* users(user_id,name,password)

We want to display for each newsitem the content and the author. 

Our base table would be the newsitems, and then we join using the item_id. Thus the query would be

```sql
SELECT *
FROM newsitems
INNER JOIN ON postitems USING (post_id)
```

This returns a "virtual table" that has looks like this result(news_id,post_id,user_id,content). 

Now we still need to get the username, so we use our result table and perform a join on the users table. Thus the query would be

```sql
SELECT *
FROM result
INNER JOIN users USING (user_id)
```

If we combine our first two queries, we end up with this

```sql
SELECT *
FROM newsitems
INNER JOIN postitems USING (post_id)
INNER JOIN users USING (user_id)
```

Conclusion: Look at A*B*C as (A*B)*C to easily understand multiple joins
