---
ID: 114
post_title: >
  ManyToMany relationships with Java
  Persistence (JSR-220)
author: timvw
post_date: 2006-01-28 02:27:24
post_excerpt: ""
layout: post
permalink: >
  http://www.timvw.be/2006/01/28/manytomany-relationships-with-java-persistence-jsr-220/
published: true
---
<p>The scenario is as following: each table can have many reservations, and each reservation can span many tables. Here is our first trial:</p>
[code lang="java"]
// Table.java
@ManyToMany(
  targetEntity=Reservation.class
)
public List getReservations() {..}

// Reservation.java
@ManyToMany(
  targetEntity=Table.class
)
public List getTables() {..}
[/code]
<p>We end up with linktables tables_reservations and reservations_tables. This is not what we want. It shouldn't be possible to remove a table when there are still reservations related to that table. We change our code so that table becomes the owner of the relationship.</p>
[code lang="java"]
// Table.java
@ManyToMany(
  targetEntity=Reservation.class,
  mappedBy="tables"
)
public List getReservations() {..}
[/code]
<p>Allright, now we only have the linktable reservations_tables. Exactly the same as we experienced with <a href="http://www.timvw.be/onetomany-relationships-with-java-persistence-jsr220/">OneToMany</a> relationships the cascading persist works when we persist a child (reservation). If we want the cascading persist to work when we persist a parent (table) we have to make sure that the child (reservation) has the parent set. An important difference is that we can't enforce this thus i advise not to use the cascade attribute on the owner (table).</p>
[code lang="java"]
// Table.java
@ManyToMany(
  targetEntity=Reservation.class,
  mappedBy="tables"
)
public List getReservations() {..}

// Reservation.java
@ManyToMany(
  targetEntity=Table.class,
  cascade=CascadeType.PERSIST
)
public List getTables() {..}
[/code]
<p>We decide to use the <a href="http://www.hibernate.org/hib_docs/annotations/reference/en/html/validator.html">Hibernate Validator</a> classes to enforce that a reservation is associated with at least one table. For some reason the SizeValidator returns true if the value is null thus we also add a NotNullValidator:</p>
[code lang="java"]
// Reservation.java
import org.hibernate.validator.*;
@ManyToMany(
  targetEntity=Table.class,
  cascade=CascadeType.PERSIST
)
@NotNull
@Size(min=1)
public List getTables() { .. }
[/code]
<p>Ok, this allows us to enforce that reservations are always associated with at least one table. We decide to allow cascading persist on the parent.</p>
[code lang="java"]
@ManyToMany(
  targetEntity=Reservation.class,
  mappedBy="tables",
  cascade=CascadeType.PERSIST
)
public List getReservations() {..}
[/code]