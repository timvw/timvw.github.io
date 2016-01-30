---
ID: 32
post_title: Select best 3 laptimes for each player
author: timvw
post_date: 2006-04-14 02:45:03
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/04/14/select-best-3-laptimes-for-each-player/
published: true
---
<p>Imagine that you have a schema where you store all the times a player needed to complete a parcours. A possible schema could be (<a href="http://www.postgresql.org">postgresql</a>):</p>

[code lang="sql"]
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
[/code]

<p>Now imagine that you want to display the best 3 results for each player. Here's how:</p>

[code lang="sql"]
SELECT *
FROM laptimes AS l1
WHERE lap_id IN (
 SELECT lap_id
 FROM laptimes AS l2
 WHERE l1.player_id = l2.player_id
 ORDER BY laptime ASC
 LIMIT 3
)
ORDER BY player_id ASC, laptime ASC;
[/code]