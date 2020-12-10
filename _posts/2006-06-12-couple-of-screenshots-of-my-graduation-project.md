---
title: Couple of screenshots of my graduation project
layout: post
tags:
  - Hibernate
---
Here are a couple of screenshots of my graduation project i've been working on last couple of weeks. The GUI is built with Swing, the bussiness rules make extensive use of the Apache BeanUtils and Hibernate Validators packages and with PostgreSQL we have a solid database. Since it takes a while to load the EntityManagerFactory we've added a simple splashscreen:

[![splashscreen](http://www.timvw.be/wp-content/images/gradtn01.png)](http://www.timvw.be/wp-content/images/grad01.png)

The base screen displays a map with the tables in the restaurant. The color of the tables depends on the state of the visit (eg: just arrived, ordered some items, eating soup, eating dessert, paid the bill). There is also the possiblity to group tables. Offcourse you have the possibility to rearrange the tables and add/remove the maps:

[![groundplan restaurant](http://www.timvw.be/wp-content/images/gradtn02.png)](http://www.timvw.be/wp-content/images/grad02.png)

[![groundplan terrace](http://www.timvw.be/wp-content/images/gradtn03.png)](http://www.timvw.be/wp-content/images/grad03.png)

As soon as the waiter has choosen a visit he can add orders via an easy to use screen. He also has the possibility to add (pre-configured and/or custom) remarks to a given order. Each order is printed on the printer of the division that is responsible for the handling for the given type of menuitems:

[![order panel](http://www.timvw.be/wp-content/images/gradtn04.png)](http://www.timvw.be/wp-content/images/grad04.png)

[![remarks dialog](http://www.timvw.be/wp-content/images/gradtn05.png)](http://www.timvw.be/wp-content/images/grad05.png)

And least but not least, there is a screen that allows the waiter to generate, print and save one or more bills for each visit. If all ordered items have been paid, the visit goes into the PAID state:

[![billing panel](http://www.timvw.be/wp-content/images/gradtn06.png)](http://www.timvw.be/wp-content/images/grad06.png)

Offcourse we've also written list/detail panels for all the tables this restaurant uses. Here are screenshots of the list and detail panel for the menuitems:

[![menuitem list](http://www.timvw.be/wp-content/images/gradtn07.png)](http://www.timvw.be/wp-content/images/grad07.png)

[![menuitem detail](http://www.timvw.be/wp-content/images/gradtn08.png)](http://www.timvw.be/wp-content/images/grad08.png)
