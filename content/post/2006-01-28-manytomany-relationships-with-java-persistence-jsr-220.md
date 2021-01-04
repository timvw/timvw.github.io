---
date: "2006-01-28T00:00:00Z"
tags:
- Hibernate
title: ManyToMany relationships with Java Persistence (JSR-220)
aliases:
 - /2006/01/28/manytomany-relationships-with-java-persistence-jsr-220/
 - /2006/01/28/manytomany-relationships-with-java-persistence-jsr-220.html
---
The scenario is as following: each table can have many reservations, and each reservation can span many tables. Here is our first trial

```java 
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
```

We end up with linktables tables_reservations and reservations_tables. This is not what we want. It should not be possible to remove a table when there are still reservations related to that table. We change our code so that table becomes the owner of the relationship.

```java  
// Table.java
@ManyToMany( 
  targetEntity=Reservation.class, 
  mappedBy="tables"
) 
public List getReservations() {..}
```

Allright, now we only have the linktable reservations_tables. Exactly the same as we experienced with [OneToMany](http://www.timvw.be/onetomany-relationships-with-java-persistence-jsr220/) relationships the cascading persist works when we persist a child (reservation). If we want the cascading persist to work when we persist a parent (table) we have to make sure that the child (reservation) has the parent set. An important difference is that we can not enforce this thus i advise not to use the cascade attribute on the owner (table).

```java
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
```

We decide to use the [Hibernate Validator](http://www.hibernate.org/hib_docs/annotations/reference/en/html/validator.html) classes to enforce that a reservation is associated with at least one table. For some reason the SizeValidator returns true if the value is null thus we also add a NotNullValidator:

```java
// Reservation.java
import org.hibernate.validator.*;
@ManyToMany( 
  targetEntity=Table.class,  
  cascade=CascadeType.PERSIST 
) 
@NotNull
@Size(min=1)
public List getTables() { .. }
```

Ok, this allows us to enforce that reservations are always associated with at least one table. We decide to allow cascading persist on the parent.

```java
@ManyToMany(  
targetEntity=Reservation.class,  
mappedBy="tables",   
cascade=CascadeType.PERSIST
) 
public List getReservations() {..}
```
