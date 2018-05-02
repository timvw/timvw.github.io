---
id: 32
title: Select best 3 laptimes for each player
date: 2006-04-14T02:45:03+00:00
author: timvw
layout: post
guid: http://www.timvw.be/select-best-3-laptimes-for-each-player/
permalink: /2006/04/14/select-best-3-laptimes-for-each-player/
tags:
  - SQL
---
Imagine that you have a schema where you store all the times a player needed to complete a parcours. A possible schema could be ([postgresql](http://www.postgresql.org))

```sql
CREATE TABLE laptimes (
lap_id SERIAL NOT NULL,
player_id INT NOT NULL,
laptime INT NOT NULL,
PRIMARY KEY (lap_id)
);

INSERT INTO laptimes (player_id, laptime) VALUES (1, 250);
INSERT INTO laptimes (player_id, laptime) VALUES (1, 450);
INSERT INTO laptimes (player_id, laptime) VALUES (1, 350);
INSERT INTO laptimes (player_id, laptime) VALUES (1, 300);
INSERT INTO laptimes (player_id, laptime) VALUES (1, 327);

INSERT INTO laptimes (player_id, laptime) VALUES (2, 327);
INSERT INTO laptimes (player_id, laptime) VALUES (2, 249);
INSERT INTO laptimes (player_id, laptime) VALUES (2, 123);
INSERT INTO laptimes (player_id, laptime) VALUES (2, 489);
INSERT INTO laptimes (player_id, laptime) VALUES (2, 158);

INSERT INTO laptimes (player_id, laptime) VALUES (3, 158);
INSERT INTO laptimes (player_id, laptime) VALUES (3, 120);
INSERT INTO laptimes (player_id, laptime) VALUES (3, 190);

INSERT INTO laptimes (player_id, laptime) VALUES (4, 600);
```

Now imagine that you want to display the best 3 results for each player. Here's how

```sql
SELECT *
FROM laptimes AS l1
WHERE lap_id IN (
SELECT lap_id
FROM laptimes AS l2
WHERE l1.player\_id = l2.player\_id
ORDER BY laptime ASC
LIMIT 3
)
ORDER BY player_id ASC, laptime ASC;
```