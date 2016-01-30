---
ID: 86
post_title: Custom ordering
author: timvw
post_date: 2004-07-18 01:06:12
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2004/07/18/custom-ordering/
published: true
---
<p>Assume we have a fruits table. And we want to select all the fruits that have a red or orange or blue color. But we want the resultset to have first all the fruits with color=red, then the fruits with color=blue and then the fruits with color=orange. It's obvious we can't use an alphabetical order. Thus we have to introduce our own order relation.</p>
[code lang="sql"]
select *
from fruits
where color = 'red' or color = 'blue' or color = 'orange'
order by case
when color = 'red' then 0
when color = 'blue' then 1
when color = 'orange' then 2
end
[/code]