---
date: "2004-07-18T00:00:00Z"
tags:
- SQL
title: Custom ordering
aliases:
 - /2004/07/18/custom-ordering/
 - /2004/07/18/custom-ordering.html
---
Assume we have a fruits table. And we want to select all the fruits that have a red or orange or blue color. But we want the resultset to have first all the fruits with color=red, then the fruits with color=blue and then the fruits with color=orange. It is obvious we can not use an alphabetical order. Thus we have to introduce our own order relation.

```sql
select *
from fruits
where color = 'red' or color = 'blue' or color = 'orange'
order by case
when color = 'red' then 0
when color = 'blue' then 1
when color = 'orange' then 2
end
```
