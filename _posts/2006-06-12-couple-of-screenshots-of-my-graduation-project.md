---
ID: 52
post_title: >
  Couple of screenshots of my graduation
  project
author: timvw
post_date: 2006-06-12 21:12:28
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/06/12/couple-of-screenshots-of-my-graduation-project/
published: true
dsq_thread_id:
  - "1933325361"
---
<p>Here are a couple of screenshots of my graduation project i've been working on last couple of weeks. The GUI is built with Swing, the bussiness rules make extensive use of the Apache BeanUtils and Hibernate Validators packages and with PostgreSQL we have a solid database. Since it takes a while to load the EntityManagerFactory we've added a simple splashscreen:</p>

<a href="http://www.timvw.be/wp-content/images/grad01.png"><img src="http://www.timvw.be/wp-content/images/gradtn01.png" alt="splashscreen"/></a>

<p>The base screen displays a map with the tables in the restaurant. The color of the tables depends on the state of the visit (eg: just arrived, ordered some items, eating soup, eating dessert, paid the bill). There is also the possiblity to group tables. Offcourse you have the possibility to rearrange the tables and add/remove the maps:</p>

<a href="http://www.timvw.be/wp-content/images/grad02.png"><img src="http://www.timvw.be/wp-content/images/gradtn02.png" alt="groundplan restaurant"/></a>


<a href="http://www.timvw.be/wp-content/images/grad03.png"><img src="http://www.timvw.be/wp-content/images/gradtn03.png" alt="groundplan terrace"/></a>

<p>As soon as the waiter has choosen a visit he can add orders via an easy to use screen. He also has the possibility to add (pre-configured and/or custom) remarks to a given order. Each order is printed on the printer of the division that is responsible for the handling for the given type of menuitems:</p>

<a href="http://www.timvw.be/wp-content/images/grad04.png"><img src="http://www.timvw.be/wp-content/images/gradtn04.png" alt="order panel"/></a>

<a href="http://www.timvw.be/wp-content/images/grad05.png"><img src="http://www.timvw.be/wp-content/images/gradtn05.png" alt="remarks dialog"/></a>

<p>And least but not least, there is a screen that allows the waiter to generate, print and save one or more bills for each visit. If all ordered items have been paid, the visit goes into the PAID state:</p>

<a href="http://www.timvw.be/wp-content/images/grad06.png"><img src="http://www.timvw.be/wp-content/images/gradtn06.png" alt="billing panel"/></a>

<p>Offcourse we've also written list/detail panels for all the tables this restaurant uses. Here are screenshots of the list and detail panel for the menuitems:</p>

<a href="http://www.timvw.be/wp-content/images/grad07.png"><img src="http://www.timvw.be/wp-content/images/gradtn07.png" alt="menuitem list"/></a>

<a href="http://www.timvw.be/wp-content/images/grad08.png"><img src="http://www.timvw.be/wp-content/images/gradtn08.png" alt="menuitem detail"/></a>